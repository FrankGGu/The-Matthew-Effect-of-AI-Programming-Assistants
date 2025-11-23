class Solution {
public:
    TreeNode* replaceValueInTree(TreeNode* root) {
        if (!root) return nullptr;

        root->val = 0;
        std::queue<TreeNode*> q;
        q.push(root);

        while (!q.empty()) {
            int size = q.size();
            int sum = 0;
            std::vector<TreeNode*> levelNodes;

            for (int i = 0; i < size; ++i) {
                TreeNode* node = q.front();
                q.pop();
                levelNodes.push_back(node);

                if (node->left) {
                    sum += node->left->val;
                    q.push(node->left);
                }
                if (node->right) {
                    sum += node->right->val;
                    q.push(node->right);
                }
            }

            for (TreeNode* node : levelNodes) {
                int siblingSum = 0;
                if (node->left) siblingSum += node->left->val;
                if (node->right) siblingSum += node->right->val;
                if (node->left) node->left->val = sum - siblingSum;
                if (node->right) node->right->val = sum - siblingSum;
            }
        }

        return root;
    }
};