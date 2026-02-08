#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int deleteAndEarn(vector<int>& nums) {
        if (nums.empty()) return 0;
        int max_num = *max_element(nums.begin(), nums.end());
        vector<int> points(max_num + 1, 0);
        for (int num : nums) {
            points[num] += num;
        }

        int prev = 0, curr = 0;
        for (int i = 0; i <= max_num; ++i) {
            int temp = max(curr, prev + points[i]);
            prev = curr;
            curr = temp;
        }
        return curr;
    }
};