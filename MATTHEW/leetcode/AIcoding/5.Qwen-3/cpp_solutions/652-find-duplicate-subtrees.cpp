#include <iostream>
#include <vector>
#include <unordered_map>
#include <string>

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
    vector<TreeNode*> findDuplicateSubtrees(TreeNode* root) {
        unordered_map<string, int> subtreeCount;
        vector<TreeNode*> result;
        serialize(root, subtreeCount, result);
        return result;
    }

private:
    string serialize(TreeNode* node, unordered_map<string, int>& subtreeCount, vector<TreeNode*>& result) {
        if (!node) {
            return "#";
        }
        string left = serialize(node->left, subtreeCount, result);
        string right = serialize(node->right, subtreeCount, result);
        string key = to_string(node->val) + "," + left + "," + right;
        subtreeCount[key]++;
        if (subtreeCount[key] == 2) {
            result.push_back(node);
        }
        return key;
    }
};