class Solution {
public:
    bool findPath(TreeNode* root, int target, string& path) {
        if (!root) return false;
        if (root->val == target) return true;
        if (findPath(root->left, target, path)) {
            path += 'L';
            return true;
        }
        if (findPath(root->right, target, path)) {
            path += 'R';
            return true;
        }
        return false;
    }

    string getDirections(TreeNode* root, int startValue, int endValue) {
        string startPath, endPath;
        findPath(root, startValue, startPath);
        findPath(root, endValue, endPath);
        reverse(startPath.begin(), startPath.end());
        reverse(endPath.begin(), endPath.end());
        int i = 0;
        while (i < startPath.size() && i < endPath.size() && startPath[i] == endPath[i]) {
            i++;
        }
        string result;
        for (int j = i; j < startPath.size(); j++) {
            result += 'U';
        }
        for (int j = i; j < endPath.size(); j++) {
            result += endPath[j];
        }
        return result;
    }
};