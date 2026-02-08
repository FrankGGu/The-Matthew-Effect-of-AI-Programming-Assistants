#include <vector>
#include <algorithm>

class Solution {
public:
    int maximumGap(std::vector<int>& nums) {
        if (nums.size() < 2) return 0;

        int maxNum = *max_element(nums.begin(), nums.end());
        int minNum = *min_element(nums.begin(), nums.end());
        int n = nums.size();
        if (maxNum == minNum) return 0;

        int bucketSize = std::max(1, (maxNum - minNum) / (n - 1));
        int bucketCount = (maxNum - minNum) / bucketSize + 1;

        std::vector<int> minBucket(bucketCount, INT_MAX);
        std::vector<int> maxBucket(bucketCount, INT_MIN);

        for (int num : nums) {
            int idx = (num - minNum) / bucketSize;
            minBucket[idx] = std::min(minBucket[idx], num);
            maxBucket[idx] = std::max(maxBucket[idx], num);
        }

        int maxGap = 0;
        int previousMax = minNum;

        for (int i = 0; i < bucketCount; i++) {
            if (minBucket[i] == INT_MAX) continue;
            maxGap = std::max(maxGap, minBucket[i] - previousMax);
            previousMax = maxBucket[i];
        }

        return maxGap;
    }
};