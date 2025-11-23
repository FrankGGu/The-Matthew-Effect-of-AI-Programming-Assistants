#include <stdlib.h> // For malloc, free

long long combinations[1001][1001];
long long MOD = 1e9 + 7;

void precompute_combinations_c(int n) {
    for (int i = 0; i <= n; ++i) {
        combinations[i][0] = 1; // C(i, 0) is always 1
        for (int j = 1; j <= i; ++j) {
            combinations[i][j] = (combinations[i-1][j-1] + combinations[i-1][j]) % MOD;
        }
    }
}

long long solve_c(int* nums, int nums_size) {
    // Base case: If the array has 0 or 1 element, there's only 1 way to form its BST.
    if (nums_size <= 1) {
        return 1;
    }

    int root_val = nums[0]; // The first element is always the root of the current subtree.

    // Dynamically allocate space for left and right subtrees.
    // The maximum possible size for either subtree is nums_size - 1.
    int* left_subtree = (int*)malloc(sizeof(int) * (nums_size - 1));
    int* right_subtree = (int*)malloc(sizeof(int) * (nums_size - 1));

    int left_count = 0;
    int right_count = 0;

    // Partition the remaining elements (from index 1 onwards) into left and right subtrees.
    for (int i = 1; i < nums_size; ++i) {
        if (nums[i] < root_val) {
            left_subtree[left_count++] = nums[i];
        } else {
            right_subtree[right_count++] = nums[i];
        }
    }

    // Recursively calculate the ways for the left and right subtrees.
    long long ways_left = solve_c(left_subtree, left_count);
    long long ways_right = solve_c(right_subtree, right_count);

    // Free the dynamically allocated memory for the subtrees to prevent memory leaks.
    free(left_subtree);
    free(right_subtree);

    // Calculate the number of ways to interleave elements from the left and right subtrees.
    // This is C(total_elements_remaining, elements_in_left_subtree).
    // total_elements_remaining = left_count + right_count
    long long current_combinations = combinations[left_count + right_count][left_count];

    // The total ways for the current subtree is the product of:
    // 1. Ways to interleave left and right subtree elements.
    // 2. Ways to reorder elements within the left subtree.
    // 3. Ways to reorder elements within the right subtree.
    return (current_combinations * ways_left % MOD * ways_right % MOD) % MOD;
}

int numOfWays(int* nums, int numsSize) {
    // Use a static flag to ensure precomputation happens only once
    // across multiple test cases in a LeetCode environment.
    static int precomputed = 0;
    if (!precomputed) {
        precompute_combinations_c(1000); // Precompute up to N=1000
        precomputed = 1;
    }

    // Call the recursive helper function.
    long long totalWays = solve_c(nums, numsSize);

    // The problem asks for the number of ways *excluding* the original order.
    // Our recursive function counts the original order as one way.
    // So, we subtract 1 from the total ways.
    // Add MOD before taking modulo to handle potential negative result from -1.
    return (int)((totalWays - 1 + MOD) % MOD);
}