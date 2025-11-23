#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> minSubsequence(vector<int>& nums) {
        sort(nums.begin(), nums.end(), greater<int>());
        int total_sum = accumulate(nums.begin(), nums.end(), 0);
        vector<int> subsequence;
        int subsequence_sum = 0;
        for (int num : nums) {
            subsequence.push_back(num);
            subsequence_sum += num;
            total_sum -= num;
            if (subsequence_sum > total_sum) {
                return subsequence;
            }
        }
        return subsequence;
    }
};