#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool primeSubOperation(vector<int>& nums) {
        int n = nums.size();
        vector<int> primes;
        vector<bool> isPrime(1001, true);
        isPrime[0] = isPrime[1] = false;
        for (int p = 2; p * p <= 1000; ++p) {
            if (isPrime[p]) {
                for (int i = p * p; i <= 1000; i += p) {
                    isPrime[i] = false;
                }
            }
        }
        for (int p = 2; p <= 1000; ++p) {
            if (isPrime[p]) {
                primes.push_back(p);
            }
        }

        for (int i = 0; i < n; ++i) {
            int prev = (i > 0) ? nums[i - 1] : 0;
            if (nums[i] <= prev) {
                return false;
            }

            auto it = upper_bound(primes.begin(), primes.end(), nums[i] - prev - 1);
            if (it != primes.begin()) {
                int p = *prev(it);
                nums[i] -= p;
            }

            if (nums[i] <= prev && i > 0)
                return false;
        }
        return true;
    }
};