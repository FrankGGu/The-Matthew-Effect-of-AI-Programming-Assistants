class Solution {
public:
    TreeNode* constructFromPrePost(vector<int>& preorder, vector<int>& postorder) {
        int n = preorder.size();
        for (int i = 0; i < n; ++i) {
            post_map[postorder[i]] = i;
        }
        return build(preorder, 0, n - 1, postorder, 0, n - 1);
    }

private:
    unordered_map<int, int> post_map;

    TreeNode* build(const vector<int>& pre, int pre_start, int pre_end,
                    const vector<int>& post, int post_start, int post_end) {
        if (pre_start > pre_end) {
            return nullptr;
        }

        TreeNode* root = new TreeNode(pre[pre_start]);
        if (pre_start == pre_end) {
            return root;
        }

        int left_root_val = pre[pre_start + 1];
        int post_idx = post_map[left_root_val];
        int num_left_nodes = post_idx - post_start + 1;

        root->left = build(pre, pre_start + 1, pre_start + num_left_nodes,
                           post, post_start, post_idx);
        root->right = build(pre, pre_start + num_left_nodes + 1, pre_end,
                            post, post_idx + 1, post_end - 1);

        return root;
    }
};