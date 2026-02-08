#include <vector>
#include <algorithm>

using namespace std;

int minSubArrayLen(int target, vector<int>& nums) {
    int n = nums.size();
    int minLen = INT_MAX;
    int windowStart = 0;
    int windowSum = 0;

    for (int windowEnd = 0; windowEnd < n; windowEnd++) {
        windowSum += nums[windowEnd];

        while (windowSum >= target) {
            minLen = min(minLen, windowEnd - windowStart + 1);
            windowSum -= nums[windowStart];
            windowStart++;
        }
    }

    return (minLen == INT_MAX) ? 0 : minLen;
}