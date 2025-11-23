#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findLength(vector<int>& nums) {
        int n = nums.size();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (nums[i] > 0) {
                count++;
            }
        }
        return count;
    }
};