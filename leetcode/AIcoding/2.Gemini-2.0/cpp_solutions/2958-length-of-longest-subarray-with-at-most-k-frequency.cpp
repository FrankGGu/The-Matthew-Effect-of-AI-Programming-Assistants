#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxSubarrayLength(vector<int>& nums, int k) {
        int left = 0;
        int maxLength = 0;
        unordered_map<int, int> frequency;

        for (int right = 0; right < nums.size(); ++right) {
            frequency[nums[right]]++;

            while (frequency[nums[right]] > k) {
                frequency[nums[left]]--;
                left++;
            }

            maxLength = max(maxLength, right - left + 1);
        }

        return maxLength;
    }
};