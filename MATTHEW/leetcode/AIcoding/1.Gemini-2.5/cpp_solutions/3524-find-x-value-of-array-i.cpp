#include <vector>

using namespace std;

class Solution {
public:
    int findFinalValue(vector<int>& nums, int original) {
        while (true) {
            bool found = false;
            for (int num : nums) {
                if (num == original) {
                    original *= 2;
                    found = true;
                    break;
                }
            }
            if (!found) {
                break;
            }
        }
        return original;
    }
};