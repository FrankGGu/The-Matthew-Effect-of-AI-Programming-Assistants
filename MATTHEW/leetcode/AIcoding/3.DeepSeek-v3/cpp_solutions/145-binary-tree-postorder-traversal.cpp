class Solution {
public:
    vector<int> postorderTraversal(TreeNode* root) {
        vector<int> result;
        stack<TreeNode*> stk;
        TreeNode* lastVisited = nullptr;
        TreeNode* node = root;

        while (node != nullptr || !stk.empty()) {
            if (node != nullptr) {
                stk.push(node);
                node = node->left;
            } else {
                TreeNode* topNode = stk.top();
                if (topNode->right != nullptr && lastVisited != topNode->right) {
                    node = topNode->right;
                } else {
                    result.push_back(topNode->val);
                    lastVisited = topNode;
                    stk.pop();
                }
            }
        }

        return result;
    }
};