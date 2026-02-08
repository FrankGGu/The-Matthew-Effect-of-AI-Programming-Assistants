#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> getDirections(TreeNode* root, int startValue, int destValue) {
        vector<int> pathToStart;
        vector<int> pathToDest;
        vector<int> result;

        findPath(root, startValue, pathToStart);
        findPath(root, destValue, pathToDest);

        int i = 0;
        while (i < pathToStart.size() && i < pathToDest.size() && pathToStart[i] == pathToDest[i]) {
            ++i;
        }

        for (int j = i; j < pathToStart.size(); ++j) {
            result.push_back(1);         }

        for (int j = pathToDest.size() - 1; j >= i; --j) {
            result.push_back(2);         }

        return result;
    }

private:
    bool findPath(TreeNode* node, int target, vector<int>& path) {
        if (!node) return false;
        if (node->val == target) return true;

        path.push_back(1);
        if (findPath(node->left, target, path)) return true;
        path.pop_back();

        path.push_back(2);
        if (findPath(node->right, target, path)) return true;
        path.pop_back();

        return false;
    }
};