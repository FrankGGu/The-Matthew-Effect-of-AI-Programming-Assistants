#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int waysToPartition(vector<int>& nums, int k) {
        int n = nums.size();
        long long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        int count = 0;
        for (int i = 0; i < n; ++i) {
            long long tempTotalSum = totalSum - nums[i] + k;
            long long prefixSum = 0;
            for (int j = 0; j < n - 1; ++j) {
                prefixSum += nums[j];
                if (prefixSum * 2 == tempTotalSum) {
                    count++;
                }
            }
        }

        int originalCount = 0;
        long long originalPrefixSum = 0;
        for (int i = 0; i < n - 1; ++i) {
            originalPrefixSum += nums[i];
            if (originalPrefixSum * 2 == totalSum) {
                originalCount++;
            }
        }

        if (k == 0) return originalCount;

        if (count == 0 && originalCount == 0) return 0;

        if (k == nums[0] && count == 0 && originalCount > 0) return originalCount;

        return count > originalCount ? count : (count == 0 ? originalCount : (originalCount > count ? originalCount : count));
    }
};