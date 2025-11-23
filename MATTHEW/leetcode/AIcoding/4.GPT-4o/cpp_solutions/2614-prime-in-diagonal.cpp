class Solution {
public:
    int diagonalPrime(vector<vector<int>>& nums) {
        int n = nums.size();
        int maxNum = 0;
        for (int i = 0; i < n; ++i) {
            maxNum = max(maxNum, nums[i][i]);
            maxNum = max(maxNum, nums[i][n - 1 - i]);
        }

        vector<bool> isPrime(maxNum + 1, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= maxNum; ++i) {
            if (isPrime[i]) {
                for (int j = i * i; j <= maxNum; j += i) {
                    isPrime[j] = false;
                }
            }
        }

        int maxPrime = 0;
        for (int i = 0; i < n; ++i) {
            if (isPrime[nums[i][i]]) {
                maxPrime = max(maxPrime, nums[i][i]);
            }
            if (isPrime[nums[i][n - 1 - i]]) {
                maxPrime = max(maxPrime, nums[i][n - 1 - i]);
            }
        }

        return maxPrime;
    }
};