#include <vector>

using namespace std;

class Solution {
public:
    long long countSubarrays(vector<int>& nums, int k) {
        int max_val = *max_element(nums.begin(), nums.end());
        long long count = 0;
        int n = nums.size();

        for (int i = 0; i < n; ++i) {
            int max_count = 0;
            for (int j = i; j < n; ++j) {
                if (nums[j] == max_val) {
                    max_count++;
                }
                if (max_count >= k) {
                    count += (n - j);
                    break;
                }
            }
        }

        return count;
    }
};