#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumGap(vector<int>& nums) {
        int n = nums.size();
        if (n < 2) return 0;

        int minVal = *min_element(nums.begin(), nums.end());
        int maxVal = *max_element(nums.begin(), nums.end());

        int bucketSize = max(1, (int)ceil((double)(maxVal - minVal) / (n - 1)));
        int bucketCount = (maxVal - minVal) / bucketSize + 1;

        vector<vector<int>> buckets(bucketCount);

        for (int num : nums) {
            int idx = (num - minVal) / bucketSize;
            buckets[idx].push_back(num);
        }

        int maxGap = 0;
        int prev = minVal;

        for (int i = 0; i < bucketCount; ++i) {
            if (buckets[i].empty()) continue;
            int currMin = *min_element(buckets[i].begin(), buckets[i].end());
            maxGap = max(maxGap, currMin - prev);
            prev = *max_element(buckets[i].begin(), buckets[i].end());
        }

        return maxGap;
    }
};