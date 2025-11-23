#include <vector>
#include <numeric>

class Solution {
public:
    int minArrayEnd(std::vector<int>& nums, int k) {
        int n = nums.size();
        int sum = std::accumulate(nums.begin(), nums.end(), 0);
        if (sum % k != 0) {
            return n;
        }

        int target = sum / k;
        int count = 0;
        int currentSum = 0;
        int minLength = n;

        for (int i = 0; i < n; ++i) {
            currentSum += nums[i];
            if (currentSum == target) {
                count++;
                currentSum = 0;
            } else if (currentSum > target) {
                return n;
            }
        }

        if (count == k) return 0;

        int left = 0;
        int right = n - 1;

        currentSum = 0;
        while (left < n) {
            currentSum += nums[left];
            if (currentSum == target) {
                minLength = std::min(minLength, left + 1);
                break;
            }
            left++;
        }

        currentSum = 0;
        while (right >= 0) {
            currentSum += nums[right];
            if (currentSum == target) {
                minLength = std::min(minLength, n - right);
                break;
            }
            right--;
        }

        return minLength;
    }
};