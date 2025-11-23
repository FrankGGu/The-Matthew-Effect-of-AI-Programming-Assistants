class Solution {
public:
    bool verifyPostorder(vector<int>& postorder) {
        return helper(postorder, 0, postorder.size() - 1);
    }

private:
    bool helper(vector<int>& postorder, int start, int end) {
        if (start >= end) return true;
        int root = postorder[end];
        int splitIndex = start;

        while (splitIndex < end && postorder[splitIndex] < root) {
            splitIndex++;
        }

        for (int i = splitIndex; i < end; i++) {
            if (postorder[i] < root) return false;
        }

        return helper(postorder, start, splitIndex - 1) && helper(postorder, splitIndex, end - 1);
    }
};