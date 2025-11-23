#include <vector>
#include <algorithm>

class Solution {
public:
    bool isPrime(int n) {
        if (n <= 1) {
            return false;
        }
        for (int i = 2; i * i <= n; ++i) {
            if (n % i == 0) {
                return false;
            }
        }
        return true;
    }

    int maximumPrimeDifference(std::vector<int>& nums) {
        int firstPrimeIndex = -1;
        int lastPrimeIndex = -1;

        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            if (isPrime(nums[i])) {
                if (firstPrimeIndex == -1) {
                    firstPrimeIndex = i;
                }
                lastPrimeIndex = i;
            }
        }

        return lastPrimeIndex - firstPrimeIndex;
    }
};