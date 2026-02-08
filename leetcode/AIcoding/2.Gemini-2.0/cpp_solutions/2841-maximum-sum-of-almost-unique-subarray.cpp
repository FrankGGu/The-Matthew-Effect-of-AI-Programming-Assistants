#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long maxSum(vector<int>& nums, int m, int k) {
        long long max_sum = 0;
        long long current_sum = 0;
        unordered_map<int, int> freq;
        int unique_count = 0;

        for (int i = 0; i < nums.size(); ++i) {
            if (freq[nums[i]] == 0) {
                unique_count++;
            }
            freq[nums[i]]++;
            current_sum += nums[i];

            if (i >= k) {
                freq[nums[i - k]]--;
                current_sum -= nums[i - k];
                if (freq[nums[i - k]] == 0) {
                    unique_count--;
                }
            }

            if (i >= k - 1 && unique_count >= m) {
                max_sum = max(max_sum, current_sum);
            }
        }

        return max_sum;
    }
};