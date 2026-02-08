#include <vector>
using namespace std;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
};

class Solution {
public:
    TreeNode* constructFromPrePost(vector<int>& pre, vector<int>& post) {
        return build(pre, post, 0, 0, pre.size());
    }

private:
    TreeNode* build(vector<int>& pre, vector<int>& post, int preStart, int postStart, int size) {
        if (size == 0) return nullptr;
        TreeNode* root = new TreeNode(pre[preStart]);
        if (size == 1) return root;

        int leftRoot = pre[preStart + 1];
        int leftSize = 0;
        for (int i = postStart; i < postStart + size; ++i) {
            if (post[i] == leftRoot) {
                leftSize = i - postStart + 1;
                break;
            }
        }

        root->left = build(pre, post, preStart + 1, postStart, leftSize);
        root->right = build(pre, post, preStart + leftSize + 1, postStart + leftSize, size - leftSize - 1);
        return root;
    }
};