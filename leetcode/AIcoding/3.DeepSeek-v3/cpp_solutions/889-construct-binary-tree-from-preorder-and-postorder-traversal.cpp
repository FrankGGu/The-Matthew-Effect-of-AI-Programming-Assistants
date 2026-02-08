class Solution {
public:
    TreeNode* constructFromPrePost(vector<int>& pre, vector<int>& post) {
        unordered_map<int, int> post_map;
        for (int i = 0; i < post.size(); ++i) {
            post_map[post[i]] = i;
        }
        return helper(pre, 0, pre.size() - 1, post, 0, post.size() - 1, post_map);
    }

    TreeNode* helper(vector<int>& pre, int pre_start, int pre_end, vector<int>& post, int post_start, int post_end, unordered_map<int, int>& post_map) {
        if (pre_start > pre_end) return nullptr;
        TreeNode* root = new TreeNode(pre[pre_start]);
        if (pre_start == pre_end) return root;

        int left_root_val = pre[pre_start + 1];
        int left_root_post_idx = post_map[left_root_val];
        int left_size = left_root_post_idx - post_start + 1;

        root->left = helper(pre, pre_start + 1, pre_start + left_size, post, post_start, left_root_post_idx, post_map);
        root->right = helper(pre, pre_start + left_size + 1, pre_end, post, left_root_post_idx + 1, post_end - 1, post_map);

        return root;
    }
};