#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int earliestSecond(vector<int>& nums, int target) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        int res = 0;
        int marked = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (count[nums[i]] > 0) {
                count[nums[i]]--;
                marked++;
                if (marked == target) {
                    return i;
                }
            }
        }
        return -1;
    }
};