#include <vector>
#include <algorithm>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    vector<int> arr;

    void inorder(TreeNode* root) {
        if (!root) return;
        inorder(root->left);
        arr.push_back(root->val);
        inorder(root->right);
    }

    int getNumber(TreeNode* root, vector<vector<int>>& ops) {
        inorder(root);
        int n = arr.size();
        int res = 0;
        for (int i = ops.size() - 1; i >= 0; --i) {
            int type = ops[i][0], x = ops[i][1], y = ops[i][2];
            auto l = lower_bound(arr.begin(), arr.end(), x);
            auto r = upper_bound(arr.begin(), arr.end(), y);
            int cnt = distance(l, r);
            if (type == 1) {
                res += cnt;
            }
            arr.erase(l, r);
            if (arr.empty()) break;
        }
        return res;
    }
};