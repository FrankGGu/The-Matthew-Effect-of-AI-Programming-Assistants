#include <iostream>
#include <vector>
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
    int countPairs(TreeNode* root, int distance) {
        int result = 0;
        function<vector<int>(TreeNode*)> dfs = [&](TreeNode* node) -> vector<int> {
            if (!node) return {};
            if (!node->left && !node->right) return {1};

            vector<int> left = dfs(node->left);
            vector<int> right = dfs(node->right);

            for (int l : left) {
                for (int r : right) {
                    if (l + r <= distance) {
                        result++;
                    }
                }
            }

            vector<int> res;
            for (int l : left) res.push_back(l + 1);
            for (int r : right) res.push_back(r + 1);
            return res;
        };

        dfs(root);
        return result;
    }
};