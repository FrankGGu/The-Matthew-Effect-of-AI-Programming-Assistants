struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

TreeNode* constructMaximumBinaryTree(vector<int>& nums) {
    if (nums.empty()) return nullptr;

    int maxIndex = max_element(nums.begin(), nums.end()) - nums.begin();
    TreeNode* root = new TreeNode(nums[maxIndex]);

    vector<int> leftSubarray(nums.begin(), nums.begin() + maxIndex);
    vector<int> rightSubarray(nums.begin() + maxIndex + 1, nums.end());

    root->left = constructMaximumBinaryTree(leftSubarray);
    root->right = constructMaximumBinaryTree(rightSubarray);

    return root;
}