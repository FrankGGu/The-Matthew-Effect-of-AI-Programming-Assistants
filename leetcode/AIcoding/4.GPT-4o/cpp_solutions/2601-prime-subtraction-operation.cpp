class Solution {
public:
    bool primeSubOperation(vector<int>& nums) {
        int n = nums.size();
        vector<bool> isPrime(1001, true);
        isPrime[0] = isPrime[1] = false;
        for (int i = 2; i * i <= 1000; ++i) {
            if (isPrime[i]) {
                for (int j = i * i; j <= 1000; j += i) {
                    isPrime[j] = false;
                }
            }
        }
        vector<int> primes;
        for (int i = 2; i <= 1000; ++i) {
            if (isPrime[i]) {
                primes.push_back(i);
            }
        }

        for (int i = n - 1; i > 0; --i) {
            if (nums[i] <= nums[i - 1]) {
                for (int p : primes) {
                    if (nums[i - 1] - p > 0 && nums[i] > nums[i - 1] - p) {
                        nums[i - 1] -= p;
                        break;
                    }
                }
                if (nums[i] >= nums[i - 1]) return false;
            }
        }
        return true;
    }
};