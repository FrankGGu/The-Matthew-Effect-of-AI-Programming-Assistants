#include <stdio.h>
#include <stdlib.h>

long long comb(int n, int k, long long* fact, long long* inv_fact) {
    if (k < 0 || k > n) return 0;
    return fact[n] * inv_fact[k] % 1000000007 * inv_fact[n - k] % 1000000007;
}

void build_tree(int* nums, int n, int* left, int* right, int* size, int root, int parent) {
    for (int i = 0; i < n; i++) {
        if (nums[i] == nums[root]) continue;
        if (nums[i] < nums[root]) {
            if (left[root] == -1) {
                left[root] = i;
                size[i] = 1;
            } else {
                build_tree(nums, n, left, right, size, left[root], root);
            }
        } else {
            if (right[root] == -1) {
                right[root] = i;
                size[i] = 1;
            } else {
                build_tree(nums, n, left, right, size, right[root], root);
            }
        }
    }
}

long long count_ways(int* nums, int n, int* left, int* right, int* size, long long* fact, long long* inv_fact) {
    if (n == 0) return 1;
    int root = 0;
    for (int i = 1; i < n; i++) {
        if (nums[i] < nums[root]) {
            if (left[root] == -1) {
                left[root] = i;
                size[i] = 1;
            } else {
                build_tree(nums, n, left, right, size, left[root], root);
            }
        } else {
            if (right[root] == -1) {
                right[root] = i;
                size[i] = 1;
            } else {
                build_tree(nums, n, left, right, size, right[root], root);
            }
        }
    }
    long long ways = 1;
    if (left[root] != -1) {
        ways = ways * count_ways(nums, size[left[root]], left, right, size, fact, inv_fact) % 1000000007;
    }
    if (right[root] != -1) {
        ways = ways * count_ways(nums, size[right[root]], left, right, size, fact, inv_fact) % 1000000007;
    }
    int total = size[root] - 1;
    int left_size = left[root] == -1 ? 0 : size[left[root]];
    int right_size = right[root] == -1 ? 0 : size[right[root]];
    ways = ways * comb(total, left_size, fact, inv_fact) % 1000000007;
    return ways;
}

long long factorial(int n, long long* fact) {
    fact[0] = 1;
    for (int i = 1; i <= n; i++) {
        fact[i] = fact[i - 1] * i % 1000000007;
    }
    return fact[n];
}

long long modinv(long long a, long long mod) {
    long long b = mod, x = 1, y = 0, z = 0, w = 1;
    while (b) {
        long long q = a / b;
        long long t = a % b;
        a = b;
        b = t;
        t = x;
        x = w - q * x;
        w = t;
        t = y;
        y = z - q * y;
        z = t;
    }
    return x % mod;
}

long long inv_factorial(int n, long long* inv_fact, long long* fact) {
    inv_fact[n] = modinv(fact[n], 1000000007);
    for (int i = n - 1; i >= 0; i--) {
        inv_fact[i] = inv_fact[i + 1] * (i + 1) % 1000000007;
    }
    return inv_fact[0];
}

int numberOfWays(int* nums, int numsSize) {
    int n = numsSize;
    long long MOD = 1000000007;
    long long* fact = (long long*)malloc((n + 1) * sizeof(long long));
    long long* inv_fact = (long long*)malloc((n + 1) * sizeof(long long));
    factorial(n, fact);
    inv_factorial(n, inv_fact, fact);
    int* left = (int*)malloc(n * sizeof(int));
    int* right = (int*)malloc(n * sizeof(int));
    int* size = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        left[i] = -1;
        right[i] = -1;
        size[i] = 1;
    }
    build_tree(nums, n, left, right, size, 0, -1);
    long long result = count_ways(nums, n, left, right, size, fact, inv_fact);
    free(fact);
    free(inv_fact);
    free(left);
    free(right);
    free(size);
    return (int)result;
}