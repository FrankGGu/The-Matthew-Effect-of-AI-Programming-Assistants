#include <vector>
#include <unordered_map>
#include <string>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
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
        if (!node) return "#";
        string serial = to_string(node->val) + "," + serialize(node->left, subtreeCount, result) + "," + serialize(node->right, subtreeCount, result);
        if (++subtreeCount[serial] == 2) {
            result.push_back(node);
        }
        return serial;
    }
};