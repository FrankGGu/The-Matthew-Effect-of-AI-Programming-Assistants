#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    bool isValidSerialization(string preorder) {
        int capacity = 1;
        int i = 0;
        while (i < preorder.size()) {
            if (capacity == 0) return false;
            if (preorder[i] == ',') {
                i++;
            } else if (preorder[i] == '#') {
                capacity--;
                i++;
            } else {
                while (i < preorder.size() && preorder[i] != ',') {
                    i++;
                }
                capacity++;
            }
        }
        return capacity == 0;
    }
};