#include <iostream>
#include <vector>
#include <unordered_set>

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
    int pseudoPalindromicPaths (TreeNode* root) {
        int count = 0;
        vector<int> path(10, 0);
        dfs(root, path, count);
        return count;
    }

private:
    void dfs(TreeNode* node, vector<int>& path, int& count) {
        if (!node) return;
        path[node->val]++;
        if (!node->left && !node->right) {
            int oddCount = 0;
            for (int i = 1; i <= 9; ++i) {
                if (path[i] % 2 != 0) ++oddCount;
            }
            if (oddCount <= 1) ++count;
        } else {
            dfs(node->left, path, count);
            dfs(node->right, path, count);
        }
        path[node->val]--;
    }
};