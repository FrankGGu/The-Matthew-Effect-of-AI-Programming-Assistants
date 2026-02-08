#include <stdbool.h>
#include <stdlib.h> // For malloc, qsort
#include <string.h> // For memcpy

static int* parent;
static int* sz; // Using size for union by size

static int* spf;

static int find(int i) {
    if (parent[i] == i) {
        return i;
    }
    return parent[i] = find(parent[i]);
}

static void unite(int i, int j) {
    int root_i = find(i);
    int root_j = find(j);
    if (root_i != root_j) {
        // Union by size
        if (sz[root_i] < sz[root_j]) {
            int temp = root_i;
            root_i = root_j;
            root_j = temp;
        }
        parent[root_j] = root_i;
        sz[root_i] += sz[root_j];
    }
}

static void sieve(int max_num) {
    spf = (int*)malloc((max_num + 1) * sizeof(int));
    for (int i = 0; i <= max_num; ++i) {
        spf[i] = i;
    }

    for (int i = 2; i * i <= max_num; ++i) {
        if (spf[i] == i) { // i is prime
            for (int j = i * i; j <= max_num; j += i) {
                if (spf[j] == j) { // Only update if not already marked by a smaller prime
                    spf[j] = i;
                }
            }
        }
    }
}

static int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

bool gcdSort(int* nums, int numsSize) {
    if (numsSize <= 1) {
        return true;
    }

    // Find max value in nums
    int max_val = 0;
    for (int i = 0; i < numsSize; ++i) {
        if (nums[i] > max_val) {
            max_val = nums[i];
        }
    }

    // Initialize DSU
    parent = (int*)malloc((max_val + 1) * sizeof(int));
    sz = (int*)malloc((max_val + 1) * sizeof(int));
    for (int i = 0; i <= max_val; ++i) {
        parent[i] = i;
        sz[i] = 1;
    }

    // Precompute smallest prime factors
    sieve(max_val);

    // Build DSU components
    // Connect each number in nums to its prime factors
    for (int i = 0; i < numsSize; ++i) {
        int num = nums[i];
        int temp_num = num;
        while (temp_num > 1) {
            int prime_factor = spf[temp_num];
            unite(num, prime_factor);
            // Divide temp_num by all occurrences of this prime_factor
            while (temp_num > 1 && temp_num % prime_factor == 0) {
                temp_num /= prime_factor;
            }
        }
    }

    // Create a sorted copy of nums
    int* sorted_nums = (int*)malloc(numsSize * sizeof(int));
    memcpy(sorted_nums, nums, numsSize * sizeof(int));
    qsort(sorted_nums, numsSize, sizeof(int), compare);

    // Check if nums can be GCD sorted
    for (int i = 0; i < numsSize; ++i) {
        if (find(nums[i]) != find(sorted_nums[i])) {
            // Free allocated memory before returning
            free(parent);
            free(sz);
            free(spf);
            free(sorted_nums);
            return false;
        }
    }

    // Free allocated memory
    free(parent);
    free(sz);
    free(spf);
    free(sorted_nums);

    return true;
}