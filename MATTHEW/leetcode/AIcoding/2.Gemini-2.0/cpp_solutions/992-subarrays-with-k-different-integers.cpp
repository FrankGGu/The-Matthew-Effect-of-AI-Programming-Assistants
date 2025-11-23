#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int subarraysWithKDistinct(vector<int>& nums, int k) {
        return atMostKDistinct(nums, k) - atMostKDistinct(nums, k - 1);
    }

private:
    int atMostKDistinct(vector<int>& nums, int k) {
        int n = nums.size();
        int left = 0;
        int count = 0;
        unordered_map<int, int> freq;
        int distinctCount = 0;

        for (int right = 0; right < n; ++right) {
            if (freq[nums[right]] == 0) {
                distinctCount++;
            }
            freq[nums[right]]++;

            while (distinctCount > k) {
                freq[nums[left]]--;
                if (freq[nums[left]] == 0) {
                    distinctCount--;
                }
                left++;
            }

            count += (right - left + 1);
        }

        return count;
    }
};