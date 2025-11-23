#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeGreatness(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int count = 0;
        int j = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] > nums[j]) {
                count++;
                j++;
            }
        }
        return count;
    }
};