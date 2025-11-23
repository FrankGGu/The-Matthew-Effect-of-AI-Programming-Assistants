#include <vector>
#include <algorithm> // For std::max

struct Node {
    int max_len;
    Node *left_child, *right_child;

    Node() : max_len(0), left_child(nullptr), right_child(nullptr) {}

    // Destructor to free memory recursively
    ~Node() {
        delete left_child;
        delete right_child;
    }
};

class Solution {
public:
    // Max coordinate value for the segment tree, based on problem constraints (1 <= nums[i] <= 10^9)
    static const int MAX_COORD = 1000000000;

    // Update function for the segment tree: sets the max_len for target_val
    void update(Node* node, int L, int R, int target_val, int new_len) {
        if (L == R) { // Leaf node
            node->max_len = std::max(node->max_len, new_len);
            return;
        }

        int M = L + (R - L) / 2;
        if (target_val <= M) {
            if (!node->left_child) node->left_child = new Node(); // Create left child if it doesn't exist
            update(node->left_child, L, M, target_val, new_len);
        } else {
            if (!node->right_child) node->right_child = new Node(); // Create right child if it doesn't exist
            update(node->right_child, M + 1, R, target_val, new_len);
        }
        // Update current node's max_len based on children
        node->max_len = std::max((node->left_child ? node->left_child->max_len : 0),
                                 (node->right_child ? node->right_child->max_len : 0));
    }

    // Query function for the segment tree: finds the maximum max_len in [query_L, query_R]
    int query(Node* node, int L, int R, int query_L, int query_R) {
        // If node does not exist, or query range is invalid, or no overlap with current node's range
        if (!node || query_L > R || query_R < L || query_L > query_R) {
            return 0;
        }
        // If current node's range is fully within the query range
        if (query_L <= L && R <= query_R) {
            return node->max_len;
        }

        int M = L + (R - L) / 2;
        // Recursively query left and right children
        int left_max = query(node->left_child, L, M, query_L, query_R);
        int right_max = query(node->right_child, M + 1, R, query_L, query_R);
        return std::max(left_max, right_max);
    }

    int longestSubsequence(std::vector<int>& nums, int k) {
        Node* root = new Node(); // Root of the dynamic segment tree
        int overall_max_len = 0;

        for (int num : nums) {
            // Calculate the valid range for the previous element (prev_num)
            // prev_num must satisfy: prev_num < num AND num - prev_num <= k
            // This implies: num - k <= prev_num < num
            // Also, prev_num must be at least 1 (minimum possible value for nums[i])
            int query_start = std::max(1, num - k);
            int query_end = num - 1;

            // Query the segment tree for the maximum LIS length ending in the valid range
            int max_prev_len = query(root, 1, MAX_COORD, query_start, query_end);

            // The current LIS length ending with 'num' is 1 + max_prev_len
            int current_len = 1 + max_prev_len;

            // Update the segment tree with this new length for 'num'
            // We take max because multiple subsequences might end at 'num'
            update(root, 1, MAX_COORD, num, current_len);

            // Update the overall maximum LIS length found so far
            overall_max_len = std::max(overall_max_len, current_len);
        }

        delete root; // Free memory allocated by the segment tree
        return overall_max_len;
    }
};