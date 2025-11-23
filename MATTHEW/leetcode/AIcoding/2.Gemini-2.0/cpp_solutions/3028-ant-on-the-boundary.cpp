#include <vector>

using namespace std;

class Solution {
public:
    int returnToBoundaryCount(vector<int>& nums) {
        int count = 0;
        int position = 0;
        for (int num : nums) {
            position += num;
            if (position == 0) {
                count++;
            }
        }
        return count;
    }
};