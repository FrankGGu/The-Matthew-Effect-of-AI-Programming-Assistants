class Solution {
public:
    vector<int> getAllElements(TreeNode* root1, TreeNode* root2) {
        vector<int> nums1, nums2;
        inorder(root1, nums1);
        inorder(root2, nums2);
        vector<int> result;
        int i = 0, j = 0;
        while (i < nums1.size() && j < nums2.size()) {
            if (nums1[i] <= nums2[j]) {
                result.push_back(nums1[i]);
                i++;
            } else {
                result.push_back(nums2[j]);
                j++;
            }
        }
        while (i < nums1.size()) {
            result.push_back(nums1[i]);
            i++;
        }
        while (j < nums2.size()) {
            result.push_back(nums2[j]);
            j++;
        }
        return result;
    }

private:
    void inorder(TreeNode* root, vector<int>& nums) {
        if (!root) return;
        inorder(root->left, nums);
        nums.push_back(root->val);
        inorder(root->right, nums);
    }
};