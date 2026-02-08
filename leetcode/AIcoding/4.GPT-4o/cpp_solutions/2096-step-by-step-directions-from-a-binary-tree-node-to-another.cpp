class Solution {
public:
    string getDirections(TreeNode* root, int startValue, int destValue) {
        vector<TreeNode*> pathToStart, pathToDest;
        findPath(root, startValue, pathToStart);
        findPath(root, destValue, pathToDest);

        int i = 0;
        while (i < pathToStart.size() && i < pathToDest.size() && pathToStart[i] == pathToDest[i]) {
            i++;
        }

        string directions;
        for (int j = i; j < pathToStart.size(); j++) {
            directions += 'U';
        }
        for (int j = i; j < pathToDest.size(); j++) {
            directions += 'L';
        }
        return directions;
    }

    bool findPath(TreeNode* root, int value, vector<TreeNode*>& path) {
        if (!root) return false;
        path.push_back(root);
        if (root->val == value) return true;
        if (findPath(root->left, value, path) || findPath(root->right, value, path)) {
            return true;
        }
        path.pop_back();
        return false;
    }
};