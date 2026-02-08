class Solution {
public:
    TreeNode* reverseOddLevels(TreeNode* root) {
        if (!root) return nullptr;
        vector<TreeNode*> levelNodes;
        queue<TreeNode*> q;
        q.push(root);
        bool isOddLevel = false;

        while (!q.empty()) {
            int size = q.size();
            levelNodes.clear();
            for (int i = 0; i < size; ++i) {
                TreeNode* node = q.front(); q.pop();
                levelNodes.push_back(node);
                if (node->left) q.push(node->left);
                if (node->right) q.push(node->right);
            }
            if (isOddLevel) {
                for (int i = 0; i < size / 2; ++i) {
                    swap(levelNodes[i]->val, levelNodes[size - 1 - i]->val);
                }
            }
            isOddLevel = !isOddLevel;
        }
        return root;
    }
};