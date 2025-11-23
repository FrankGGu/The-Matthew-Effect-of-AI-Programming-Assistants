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
    TreeNode* constructFromPrePost(vector<int>& preorder, vector<int>& postorder) {
        unordered_map<int, int> post_index;
        for (int i = 0; i < postorder.size(); ++i) {
            post_index[postorder[i]] = i;
        }

        return buildTree(preorder, 0, preorder.size() - 1, postorder, 0, postorder.size() - 1, post_index);
    }

private:
    TreeNode* buildTree(vector<int>& preorder, int pre_start, int pre_end,
                           vector<int>& postorder, int post_start, int post_end,
                           unordered_map<int, int>& post_index) {
        if (pre_start > pre_end) {
            return nullptr;
        }

        TreeNode* root = new TreeNode(preorder[pre_start]);

        if (pre_start == pre_end) {
            return root;
        }

        int left_root_val = preorder[pre_start + 1];
        int left_root_index_in_post = post_index[left_root_val];
        int left_size = left_root_index_in_post - post_start + 1;

        root->left = buildTree(preorder, pre_start + 1, pre_start + left_size,
                                postorder, post_start, left_root_index_in_post, post_index);
        root->right = buildTree(preorder, pre_start + left_size + 1, pre_end,
                                 postorder, left_root_index_in_post + 1, post_end - 1, post_index);

        return root;
    }
};