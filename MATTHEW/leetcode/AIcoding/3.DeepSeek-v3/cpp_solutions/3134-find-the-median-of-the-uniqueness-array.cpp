#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int medianOfUniquenessArray(vector<int>& nums) {
        int n = nums.size();
        long long total = (long long)n * (n + 1) / 2;
        int k = (total + 1) / 2;

        int left = 1, right = n;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (countSubarraysWithAtMostKDistinct(nums, mid) >= k) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

private:
    long long countSubarraysWithAtMostKDistinct(vector<int>& nums, int k) {
        unordered_map<int, int> freq;
        int left = 0;
        long long count = 0;
        int distinct = 0;

        for (int right = 0; right < nums.size(); ++right) {
            if (freq[nums[right]] == 0) {
                distinct++;
            }
            freq[nums[right]]++;

            while (distinct > k) {
                freq[nums[left]]--;
                if (freq[nums[left]] == 0) {
                    distinct--;
                }
                left++;
            }
            count += right - left + 1;
        }
        return count;
    }
};