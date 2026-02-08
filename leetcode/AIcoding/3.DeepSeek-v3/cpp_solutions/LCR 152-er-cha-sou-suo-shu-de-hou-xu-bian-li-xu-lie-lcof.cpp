class Solution {
public:
    bool verifyPostorder(vector<int>& postorder) {
        return helper(postorder, 0, postorder.size() - 1);
    }

    bool helper(vector<int>& postorder, int left, int right) {
        if (left >= right) {
            return true;
        }
        int root = postorder[right];
        int mid = left;
        while (mid < right && postorder[mid] < root) {
            mid++;
        }
        for (int i = mid; i < right; i++) {
            if (postorder[i] < root) {
                return false;
            }
        }
        return helper(postorder, left, mid - 1) && helper(postorder, mid, right - 1);
    }
};