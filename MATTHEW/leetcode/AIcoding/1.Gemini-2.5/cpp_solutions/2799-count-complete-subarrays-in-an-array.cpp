#include <vector>
#include <unordered_set>
#include <unordered_map>

class Solution {
public:
    int countCompleteSubarrays(std::vector<int>& nums) {
        std::unordered_set<int> distinct_elements(nums.begin(), nums.end());
        int k = distinct_elements.size();

        int n = nums.size();
        int count = 0;
        int left = 0;
        std::unordered_map<int, int> window_counts;

        for (int right = 0; right < n; ++right) {
            window_counts[nums[right]]++;

            while (window_counts.size() == k) {
                count += (n - right);

                window_counts[nums[left]]--;
                if (window_counts[nums[left]] == 0) {
                    window_counts.erase(nums[left]);
                }
                left++;
            }
        }

        return count;
    }
};