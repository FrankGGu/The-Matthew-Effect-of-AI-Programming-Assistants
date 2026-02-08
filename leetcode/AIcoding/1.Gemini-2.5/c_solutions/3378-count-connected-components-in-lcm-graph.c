#include <stdlib.h> // For malloc, free
#include <string.h> // For memset

typedef struct {
    int* parent;
    int* sz; // size of the component
    int count;
} DSU;

void dsu_init(DSU* dsu, int n) {
    dsu->parent = (int*)malloc(n * sizeof(int));
    dsu->sz = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; ++i) {
        dsu->parent[i] = i;
        dsu->sz[i] = 1;
    }
    dsu->count = n;
}

void dsu_free(DSU* dsu) {
    free(dsu->parent);
    free(dsu->sz);
}

int dsu_find(DSU* dsu, int i) {
    if (dsu->parent[i] == i) {
        return i;
    }
    return dsu->parent[i] = dsu_find(dsu, dsu->parent[i]);
}

void dsu_union(DSU* dsu, int i, int j) {
    int root_i = dsu_find(dsu, i);
    int root_j = dsu_find(dsu, j);

    if (root_i != root_j) {
        // Union by size
        if (dsu->sz[root_i] < dsu->sz[root_j]) {
            int temp = root_i;
            root_i = root_j;
            root_j = temp;
        }
        dsu->parent[root_j] = root_i;
        dsu->sz[root_i] += dsu->sz[root_j];
        dsu->count--;
    }
}

#define MAX_VAL 100001
static int spf[MAX_VAL]; // Smallest Prime Factor
static int prime_to_node_rep[MAX_VAL]; // Maps prime factor to a node index (representative)
static int sieve_initialized = 0;

void sieve_spf_init() {
    for (int i = 0; i < MAX_VAL; ++i) {
        spf[i] = i; // Initialize spf[i] to i (itself)
    }

    for (int i = 2; i < MAX_VAL; ++i) {
        if (spf[i] == i) { // i is prime
            // Mark multiples of i with i as their smallest prime factor
            // Start j from i*i for optimization, as smaller multiples would have been marked by smaller primes
            for (long long j = (long long)i * i; j < MAX_VAL; j += i) {
                if (spf[j] == j) { // Only update if j's spf is still itself (not marked by a smaller prime yet)
                    spf[j] = i;
                }
            }
        }
    }
    sieve_initialized = 1;
}

int countComponents(int n, int* nums, int numsSize) {
    // Initialize DSU
    DSU dsu;
    dsu_init(&dsu, n);

    // Ensure sieve is run only once across all test cases
    if (!sieve_initialized) {
        sieve_spf_init();
    }

    // Initialize prime_to_node_rep for this specific test case
    // This is crucial because it's a global static array and its state persists.
    // We need to reset it for each call to countComponents.
    memset(prime_to_node_rep, -1, sizeof(prime_to_node_rep));

    for (int i = 0; i < numsSize; ++i) {
        int num = nums[i];

        // Numbers equal to 1 have no prime factors greater than 1, so they cannot form connections
        // based on the problem's criteria (common factor > 1).
        // The factorization loop will naturally skip num=1.
        if (num == 1) {
            continue;
        }

        // Factorize num using the precomputed Smallest Prime Factor (SPF) array
        int temp_num = num; // Use a temporary variable as num will be modified
        while (temp_num > 1) {
            int p = spf[temp_num]; // Get the smallest prime factor of temp_num

            if (prime_to_node_rep[p] == -1) {
                // If this prime factor 'p' has not been seen before,
                // associate it with the current node 'i'.
                prime_to_node_rep[p] = i;
            } else {
                // If 'p' has been seen before (i.e., prime_to_node_rep[p] holds an index 'j'),
                // it means nums[i] and nums[j] both share 'p' as a common factor.
                // Therefore, nodes 'i' and 'j' are connected. Union their sets.
                dsu_union(&dsu, i, prime_to_node_rep[p]);
            }

            // Divide out all occurrences of this prime factor 'p' from temp_num.
            // This ensures that we only process distinct prime factors for a given number.
            while (temp_num > 1 && temp_num % p == 0) {
                temp_num /= p;
            }
        }
    }

    int result = dsu.count;
    dsu_free(&dsu); // Free DSU memory
    return result;
}