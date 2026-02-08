#include <vector>

using namespace std;

class Solution {
public:
    bool verifyPostorder(vector<int>& postorder) {
        return verify(postorder, 0, postorder.size() - 1);
    }

private:
    bool verify(vector<int>& postorder, int start, int end) {
        if (start >= end) {
            return true;
        }

        int root = postorder[end];
        int i = start;
        while (i < end && postorder[i] < root) {
            i++;
        }

        int j = i;
        while (j < end) {
            if (postorder[j] < root) {
                return false;
            }
            j++;
        }

        return verify(postorder, start, i - 1) && verify(postorder, i, end - 1);
    }
};