class Solution {
public:
    int maxDepth(Node* root) {
        if (root == nullptr) {
            return 0;
        }

        int max_child_depth = 0;
        for (Node* child : root->children) {
            max_child_depth = std::max(max_child_depth, maxDepth(child));
        }

        return 1 + max_child_depth;
    }
};