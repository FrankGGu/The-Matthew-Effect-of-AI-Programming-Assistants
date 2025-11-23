#include <vector>

using namespace std;

class Solution {
public:
    bool verifyPostorder(vector<int>& postorder) {
        return verify(postorder, 0, postorder.size() - 1);
    }

private:
    bool verify(vector<int>& postorder, int left, int right) {
        if (left >= right) return true;

        int rootVal = postorder[right];
        int i = left;
        while (i < right && postorder[i] < rootVal) {
            i++;
        }

        for (int j = i; j < right; j++) {
            if (postorder[j] < rootVal) return false;
        }

        return verify(postorder, left, i - 1) && verify(postorder, i, right - 1);
    }
};