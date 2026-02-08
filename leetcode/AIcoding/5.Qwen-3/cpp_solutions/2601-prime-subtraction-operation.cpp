#include <iostream>
#include <vector>
#include <algorithm>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool primeSubOperation(vector<int>& nums) {
        int max_num = *max_element(nums.begin(), nums.end());
        vector<bool> is_prime(max_num + 1, true);
        is_prime[0] = is_prime[1] = false;
        for (int i = 2; i * i <= max_num; ++i) {
            if (is_prime[i]) {
                for (int j = i * i; j <= max_num; j += i) {
                    is_prime[j] = false;
                }
            }
        }

        unordered_set<int> primes;
        for (int i = 2; i <= max_num; ++i) {
            if (is_prime[i]) {
                primes.insert(i);
            }
        }

        for (int i = 0; i < nums.size(); ++i) {
            int target = nums[i];
            bool found = false;
            for (int p : primes) {
                if (p >= target) break;
                if (primes.find(target - p) != primes.end()) {
                    nums[i] -= p;
                    found = true;
                    break;
                }
            }
            if (!found) {
                return false;
            }
        }

        return true;
    }
};