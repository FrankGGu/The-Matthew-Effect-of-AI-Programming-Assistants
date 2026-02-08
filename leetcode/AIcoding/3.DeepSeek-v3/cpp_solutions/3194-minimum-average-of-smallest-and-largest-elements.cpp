#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    double minimumAverage(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        double min_avg = INT_MAX;
        int n = nums.size();
        for (int i = 0; i <= n / 2; ++i) {
            double avg = (nums[i] + nums[n - 1 - i]) / 2.0;
            if (avg < min_avg) {
                min_avg = avg;
            }
        }
        return min_avg;
    }
};