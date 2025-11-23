class Solution {
public:
    vector<int> inorder;

    void inorderTraversal(TreeNode* root) {
        if (root == nullptr) return;
        inorderTraversal(root->left);
        inorder.push_back(root->val);
        inorderTraversal(root->right);
    }

    vector<vector<int>> closestNodes(TreeNode* root, vector<int>& queries) {
        inorder.clear();
        inorderTraversal(root);

        vector<vector<int>> result;
        for (int query : queries) {
            int lower = -1, upper = -1;

            auto lower_bound = lower_bound(inorder.begin(), inorder.end(), query);
            if (lower_bound != inorder.begin()) {
                lower = *prev(lower_bound);
            }
            if (lower_bound != inorder.end() && *lower_bound == query) {
                lower = *lower_bound;
            } else if (lower_bound == inorder.begin() && !inorder.empty() && inorder[0] <= query){
                lower = inorder[0];
            }

            auto upper_bound = upper_bound(inorder.begin(), inorder.end(), query);
            if (upper_bound != inorder.end()) {
                upper = *upper_bound;
            }

            if(lower_bound != inorder.end() && *lower_bound <= query){
                lower = *lower_bound;
            }

            if (lower_bound == inorder.begin() && lower_bound != inorder.end() && *lower_bound > query){
                lower = -1;
            }

            if(lower_bound == inorder.end()){
                if(!inorder.empty() && inorder.back() <= query){
                    lower = inorder.back();
                } else {
                    lower = -1;
                }
            }

            result.push_back({lower, upper});
        }

        return result;
    }
};