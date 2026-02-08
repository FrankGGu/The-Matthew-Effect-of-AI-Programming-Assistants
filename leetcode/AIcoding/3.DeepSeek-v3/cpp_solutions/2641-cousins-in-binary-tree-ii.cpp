class Solution {
public:
    TreeNode* replaceValueInTree(TreeNode* root) {
        if (!root) return nullptr;

        queue<TreeNode*> q;
        q.push(root);
        root->val = 0;

        while (!q.empty()) {
            int size = q.size();
            vector<TreeNode*> levelNodes;
            int levelSum = 0;

            for (int i = 0; i < size; ++i) {
                TreeNode* node = q.front();
                q.pop();
                levelNodes.push_back(node);

                if (node->left) {
                    q.push(node->left);
                    levelSum += node->left->val;
                }
                if (node->right) {
                    q.push(node->right);
                    levelSum += node->right->val;
                }
            }

            for (TreeNode* node : levelNodes) {
                int childrenSum = 0;
                if (node->left) childrenSum += node->left->val;
                if (node->right) childrenSum += node->right->val;

                if (node->left) node->left->val = levelSum - childrenSum;
                if (node->right) node->right->val = levelSum - childrenSum;
            }
        }

        return root;
    }
};