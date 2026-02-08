#include <stdlib.h> // For malloc, free, realloc
#include <string.h> // For memset (though not strictly needed with explicit init)

#define N_MAX 100005
#define MOD 1000000007

static int size_arr[N_MAX];
static long long dp_arr[N_MAX];
static long long fact[N_MAX];
static long long invFact[N_MAX];

typedef struct {
    int* data;
    int capacity;
    int size;
} IntVector;

static IntVector* adj; // Array of IntVectors to represent adjacency list

void initIntVector(IntVector* vec, int initialCapacity) {
    vec->data = (int*)malloc(sizeof(int) * initialCapacity);
    vec->capacity = initialCapacity;
    vec->size = 0;
}

void addToIntVector(IntVector* vec, int val) {
    if (vec->size == vec->capacity) {
        vec->capacity *= 2; // Double capacity
        vec->data = (int*)realloc(vec->data, sizeof(int) * vec->capacity);
        // Error handling for realloc failure is omitted for brevity in competitive programming context
    }
    vec->data[vec->size++] = val;
}

void freeIntVector(IntVector* vec) {
    free(vec->data);
    vec->data = NULL;
    vec->capacity = 0;
    vec->size = 0;
}

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

long long modInverse(long long n) {
    return power(n, MOD - 2);
}

void precompute_factorials(int n_max_val) {
    fact[0] = 1;
    invFact[0] = 1;
    for (int i = 1; i <= n_max_val; i++) {
        fact[i] = (fact[i - 1] * i) % MOD;
        invFact[i] = modInverse(fact[i]);
    }
}

void dfs(int u) {
    size_arr[u] = 1;
    dp_arr[u] = 1; // Initialize for multiplication

    long long product_of_child_dp = 1;
    long long product_of_child_inv_fact_sizes = 1;

    // Iterate through children of u
    for (int i = 0; i < adj[u].size; i++) {
        int v = adj[u].data[i];
        dfs(v); // Recursively call DFS for child v

        size_arr[u] += size_arr[v]; // Add child's subtree size to current node's size

        // Accumulate product of dp values of children
        product_of_child_dp = (product_of_child_dp * dp_arr[v]) % MOD;

        // Accumulate product of inverse factorials of children's subtree sizes
        product_of_child_inv_fact_sizes = (product_of_child_inv_fact_sizes * invFact[size_arr[v]]) % MOD;
    }

    // The formula for dp[u] is:
    // dp[u] = ( (size[u]-1)! / (size[c1]! * ... * size[ck]!) ) * dp[c1] * ... * dp[ck]
    // where c1, ..., ck are children of u.
    // (size[u]-1)! is fact[size_arr[u] - 1]
    // 1 / (size[c1]! * ... * size[ck]!) is product_of_child_inv_fact_sizes
    // dp[c1] * ... * dp[ck] is product_of_child_dp

    // Calculate the multinomial coefficient part: (size[u]-1)! / (product of size[ci]!)
    dp_arr[u] = (fact[size_arr[u] - 1] * product_of_child_inv_fact_sizes) % MOD;

    // Multiply by the product of children's dp values
    dp_arr[u] = (dp_arr[u] * product_of_child_dp) % MOD;
}

int waysToBuildRooms(int n, int* parent, int parentSize) {
    // Allocate memory for the array of IntVectors (adjacency list)
    adj = (IntVector*)malloc(sizeof(IntVector) * n);
    for (int i = 0; i < n; i++) {
        initIntVector(&adj[i], 2); // Initialize each IntVector with an initial capacity of 2
    }

    // Build the adjacency list (tree structure)
    // Room 0 has no parent, so we iterate from room 1 to n-1
    for (int i = 1; i < n; i++) {
        addToIntVector(&adj[parent[i]], i); // Add i as a child of parent[i]
    }

    // Precompute factorials and inverse factorials up to n
    precompute_factorials(n);

    // Perform DFS starting from room 0, as it's the only root
    dfs(0);

    // Free allocated memory for the adjacency list
    for (int i = 0; i < n; i++) {
        freeIntVector(&adj[i]);
    }
    free(adj);
    adj = NULL; // Set to NULL to prevent potential double-free issues if called again

    // The result is the dp value of the root (room 0)
    return (int)dp_arr[0];
}