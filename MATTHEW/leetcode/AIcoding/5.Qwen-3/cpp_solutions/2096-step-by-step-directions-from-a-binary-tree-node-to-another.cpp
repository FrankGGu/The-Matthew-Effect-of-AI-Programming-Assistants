#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    string getDirections(TreeNode* root, int startValue, int endValue) {
        string pathToStart, pathToEnd;
        findPath(root, startValue, pathToStart);
        findPath(root, endValue, pathToEnd);

        int i = 0;
        while (i < pathToStart.size() && i < pathToEnd.size() && pathToStart[i] == pathToEnd[i]) {
            ++i;
        }

        string result;
        for (int j = i; j < pathToStart.size(); ++j) {
            result += "U";
        }
        for (int j = i; j < pathToEnd.size(); ++j) {
            result += pathToEnd[j];
        }

        return result;
    }

private:
    bool findPath(TreeNode* node, int target, string& path) {
        if (!node) return false;
        if (node->val == target) return true;

        path.push_back('L');
        if (findPath(node->left, target, path)) return true;
        path.pop_back();

        path.push_back('R');
        if (findPath(node->right, target, path)) return true;
        path.pop_back();

        return false;
    }
};