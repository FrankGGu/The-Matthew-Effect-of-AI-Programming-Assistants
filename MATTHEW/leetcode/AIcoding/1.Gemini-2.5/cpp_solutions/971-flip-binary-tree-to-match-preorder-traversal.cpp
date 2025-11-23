class Solution {
public:
    std::vector<int> flipped;
    int i; // global index for voyage

    bool dfs(TreeNode* node, const std::vector<int>& voyage) {
        if (!node) {
            return true;
        }

        // Check if i is out of bounds or value mismatch
        if (i >= voyage.size() || node->val != voyage[i]) {
            return false;
        }

        i++; // Move to the next expected value in voyage

        // Check if a flip is necessary
        // A flip is necessary if node->left exists, and its value doesn't match voyage[i],
        // BUT node->right exists and its value DOES match voyage[i].
        // This implies node->right must be the next in preorder, so we flip.
        // Also need to check i < voyage.size() before accessing voyage[i] for children
        if (node->left && i < voyage.size() && node->left->val != voyage[i] &&
            node->right && i < voyage.size() && node->right->val == voyage[i]) {

            flipped.push_back(node->val);
            // Traverse right child first (as if it's the left child)
            // Then traverse left child (as if it's the right child)
            return dfs(node->right, voyage) && dfs(node->left, voyage);
        } else {
            // No flip needed or possible (e.g., only left child, or only right child, or no children)
            // Traverse left child first
            // Then traverse right child
            return dfs(node->left, voyage) && dfs(node->right, voyage);
        }
    }

    std::vector<int> flipMatchVoyage(TreeNode* root, std::vector<int>& voyage) {
        i = 0; // Initialize global index
        flipped.clear(); // Clear previous results if any

        // If dfs returns true AND all elements in voyage were consumed, it's a match.
        // Otherwise, it's impossible.
        if (dfs(root, voyage) && i == voyage.size()) {
            return flipped;
        } else {
            return {-1};
        }
    }
};