#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    bool verifyPostorder(vector<int>& postorder) {
        return helper(postorder, 0, postorder.size() - 1);
    }

private:
    bool helper(vector<int>& postorder, int left, int right) {
        if (left >= right) return true;
        int root = postorder[right];
        int i = left;
        while (i < right && postorder[i] < root) ++i;
        int j = i;
        while (j < right && postorder[j] > root) ++j;
        if (j != right) return false;
        return helper(postorder, left, i - 1) && helper(postorder, i, right - 1);
    }
};