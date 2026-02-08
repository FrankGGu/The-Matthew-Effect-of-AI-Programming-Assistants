#include <vector>
#include <algorithm>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int distinctAverages(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int left = 0, right = nums.size() - 1;
        unordered_set<double> averages;
        while (left < right) {
            averages.insert((double)(nums[left] + nums[right]) / 2.0);
            left++;
            right--;
        }
        return averages.size();
    }
};