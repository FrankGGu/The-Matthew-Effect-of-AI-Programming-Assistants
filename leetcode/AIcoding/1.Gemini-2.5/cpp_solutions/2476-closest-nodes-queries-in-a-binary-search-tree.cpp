class Solution {
public:
    vector<vector<int>> closestNodes(TreeNode* root, vector<int>& queries) {
        vector<int> sorted_nodes;
        inorder(root, sorted_nodes);

        vector<vector<int>> result;
        for (int query : queries) {
            int min_val = -1;
            int max_val = -1;

            auto it_max = lower_bound(sorted_nodes.begin(), sorted_nodes.end(), query);
            if (it_max != sorted_nodes.end()) {
                max_val = *it_max;
            }

            auto it_min = upper_bound(sorted_nodes.begin(), sorted_nodes.end(), query);
            if (it_min != sorted_nodes.begin()) {
                min_val = *(--it_min);
            }

            result.push_back({min_val, max_val});
        }

        return result;
    }

private:
    void inorder(TreeNode* node, vector<int>& vec) {
        if (!node) {
            return;
        }
        inorder(node->left, vec);
        vec.push_back(node->val);
        inorder(node->right, vec);
    }
};