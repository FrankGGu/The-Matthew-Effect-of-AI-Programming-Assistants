#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long countInterestingSubarrays(vector<int>& nums, int modulo, int k) {
        int n = nums.size();
        long long count = 0;
        unordered_map<int, int> prefixSumCount;
        prefixSumCount[0] = 1;
        int prefixSum = 0;

        for (int i = 0; i < n; ++i) {
            if (nums[i] % modulo == k) {
                prefixSum = (prefixSum + 1) % modulo;
            } else if (nums[i] % modulo != 0) {
                prefixSum = (prefixSum + (nums[i] % modulo == 0 ? 0 : 0)) % modulo;
            }

            int target = (prefixSum - k + modulo) % modulo;
            count += prefixSumCount[target];
            prefixSumCount[prefixSum]++;
        }

        return count;
    }
};