#include <iostream>
#include <vector>
#include <string>
#include <sstream>

using namespace std;

class Solution {
public:
    bool verifyPreorder(vector<int>& preorder) {
        int index = 0;
        return verify(preorder, index);
    }

private:
    bool verify(vector<int>& preorder, int& index) {
        if (index >= preorder.size()) {
            return false;
        }
        if (preorder[index] == -1) {
            index++;
            return true;
        }
        index++;
        bool left = verify(preorder, index);
        bool right = verify(preorder, index);
        return left && right;
    }
};