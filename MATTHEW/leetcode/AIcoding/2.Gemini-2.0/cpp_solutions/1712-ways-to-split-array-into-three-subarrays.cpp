#include <vector>

using namespace std;

class Solution {
public:
    int waysToSplit(vector<int>& nums) {
        int n = nums.size();
        vector<int> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        int count = 0;
        int mod = 1e9 + 7;
        for (int i = 1; i < n - 1; ++i) {
            int leftSum = prefixSum[i];
            int left = i + 1;
            int right = n - 1;
            int leftIndex = -1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                int midSum = prefixSum[mid] - prefixSum[i];
                if (midSum >= leftSum) {
                    leftIndex = mid;
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }

            left = i + 1;
            right = n - 1;
            int rightIndex = -1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                int midSum = prefixSum[mid] - prefixSum[i];
                int rightSum = prefixSum[n] - prefixSum[mid];
                if (midSum <= rightSum) {
                    rightIndex = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }

            if (leftIndex != -1 && rightIndex != -1 && leftIndex <= rightIndex) {
                count = (count + (rightIndex - leftIndex + 1)) % mod;
            }
        }

        return count;
    }
};