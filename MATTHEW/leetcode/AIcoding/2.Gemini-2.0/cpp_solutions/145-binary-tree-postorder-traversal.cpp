class Solution {
public:
    vector<int> postorderTraversal(TreeNode* root) {
        vector<int> result;
        if (!root) return result;

        stack<TreeNode*> s;
        TreeNode* lastVisited = nullptr;
        TreeNode* current = root;

        while (!s.empty() || current) {
            if (current) {
                s.push(current);
                current = current->left;
            } else {
                TreeNode* topNode = s.top();
                if (topNode->right && lastVisited != topNode->right) {
                    current = topNode->right;
                } else {
                    result.push_back(topNode->val);
                    lastVisited = topNode;
                    s.pop();
                }
            }
        }

        return result;
    }
};