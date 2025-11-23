#include <algorithm>
#include <vector>

using namespace std;

class Solution {
public:
    int maxIncreasingGroups(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        long long sum = 0;
        int count = 0;
        for (int num : nums) {
            sum += num;
            if (sum >= (long long)(count + 1) * (count + 2) / 2) {
                count++;
            }
        }
        return count;
    }
};