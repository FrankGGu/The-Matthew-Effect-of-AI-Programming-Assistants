class Solution {
public:
    vector<int> findMode(TreeNode* root) {
        vector<int> modes;
        int maxCount = 0, currentCount = 0, prevVal = INT_MIN;
        inorder(root, modes, maxCount, currentCount, prevVal);
        return modes;
    }

private:
    void inorder(TreeNode* node, vector<int>& modes, int& maxCount, int& currentCount, int& prevVal) {
        if (!node) return;

        inorder(node->left, modes, maxCount, currentCount, prevVal);

        if (node->val == prevVal) {
            currentCount++;
        } else {
            currentCount = 1;
        }

        if (currentCount > maxCount) {
            maxCount = currentCount;
            modes.clear();
            modes.push_back(node->val);
        } else if (currentCount == maxCount) {
            modes.push_back(node->val);
        }

        prevVal = node->val;

        inorder(node->right, modes, maxCount, currentCount, prevVal);
    }
};