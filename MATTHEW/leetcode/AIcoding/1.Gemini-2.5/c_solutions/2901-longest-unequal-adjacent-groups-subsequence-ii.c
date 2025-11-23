#include <stdlib.h>
#include <stdbool.h>

struct Group {
    int size;
    int color;
};

bool is_lex_smaller(int idx1, int idx2, int* prev_idx_arr, int N_groups) {
    // Reconstruct paths from end to start
    // Using fixed-size arrays for simplicity, N_groups is the maximum possible path length.
    int path1_nodes[N_groups];
    int path2_nodes[N_groups];
    int p1_len = 0;
    int p2_len = 0;

    int curr = idx1;
    while (curr != -1) {
        path1_nodes[p1_len++] = curr;
        curr = prev_idx_arr[curr];
    }
    // Reverse path1_nodes to get actual order (from start to end)
    for (int k = 0; k < p1_len / 2; ++k) {
        int temp = path1_nodes[k];
        path1_nodes[k] = path1_nodes[p1_len - 1 - k];
        path1_nodes[p1_len - 1 - k] = temp;
    }

    curr = idx2;
    while (curr != -1) {
        path2_nodes[p2_len++] = curr;
        curr = prev_idx_arr[curr];
    }
    // Reverse path2_nodes to get actual order (from start to end)
    for (int k = 0; k < p2_len / 2; ++k) {
        int temp = path2_nodes[k];
        path2_nodes[k] = path2_nodes[p2_len - 1 - k];
        path2_nodes[p2_len - 1 - k] = temp;
    }

    // At this point, p1_len and p2_len must be equal because they represent
    // lengths of paths that contributed to the same 'dp' value.
    // Compare elements lexicographically
    for (int k = 0; k < p1_len; ++k) {
        if (path1_nodes[k] < path2_nodes[k]) return true;
        if (path1_nodes[k] > path2_nodes[k]) return false;
    }
    return false; // Paths are identical, so neither is strictly smaller.
}

int* getLongestSubsequence(struct Group* groups, int groupsSize, int* returnSize) {
    // groupsSize is guaranteed to be at least 1.
    // No need for groupsSize == 0 check.

    // dp[i] stores the length of the longest valid subsequence ending at index i.
    int* dp = (int*)malloc(groupsSize * sizeof(int));
    // prev_idx[i] stores the index of the group that precedes group i in the longest subsequence ending at i.
    int* prev_idx = (int*)malloc(groupsSize * sizeof(int));

    int max_len = 0;
    int last_idx_of_max_len_path = -1; // Stores the ending index of the overall longest subsequence found so far.

    for (int i = 0; i < groupsSize; ++i) {
        dp[i] = 1; // A single group itself forms a subsequence of length 1.
        prev_idx[i] = -1; // No previous element for a subsequence of length 1.

        for (int j = 0; j < i; ++j) {
            // Check the conditions for adjacent groups in the subsequence:
            // 1. Their sizes must be different.
            // 2. Their colors must be different.
            if (groups[j].size != groups[i].size && groups[j].color != groups[i].color) {
                if (dp[j] + 1 > dp[i]) {
                    // Found a longer subsequence ending at i.
                    dp[i] = dp[j] + 1;
                    prev_idx[i] = j;
                } else if (dp[j] + 1 == dp[i]) {
                    // Found a subsequence of the same length.
                    // Apply lexicographical tie-breaking.
                    // Compare the path ending at j with the path ending at prev_idx[i].
                    // Since dp[j]+1 == dp[i] and dp[prev_idx[i]]+1 == dp[i], it implies dp[j] == dp[prev_idx[i]].
                    // Thus, the paths ending at j and prev_idx[i] have the same length.
                    if (is_lex_smaller(j, prev_idx[i], prev_idx, groupsSize)) {
                        prev_idx[i] = j; // Update to the lexicographically smaller path.
                    }
                }
            }
        }

        // Update the overall maximum length and its ending index.
        if (dp[i] > max_len) {
            max_len = dp[i];
            last_idx_of_max_len_path = i;
        } else if (dp[i] == max_len) {
            // Tie-breaking for the overall maximum length.
            // Compare the path ending at i with the current best path (ending at last_idx_of_max_len_path).
            if (is_lex_smaller(i, last_idx_of_max_len_path, prev_idx, groupsSize)) {
                last_idx_of_max_len_path = i; // Update to the lexicographically smaller path.
            }
        }
    }

    // Reconstruct the final path using prev_idx array.
    int* result = (int*)malloc(max_len * sizeof(int));
    *returnSize = max_len;

    int current_idx = last_idx_of_max_len_path;
    // Fill the result array from end to start, then it will be in correct order.
    for (int k = max_len - 1; k >= 0; --k) {
        result[k] = current_idx;
        current_idx = prev_idx[current_idx];
    }

    free(dp);
    free(prev_idx);

    return result;
}