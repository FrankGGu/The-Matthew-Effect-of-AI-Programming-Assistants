#include <vector>
#include <algorithm>
#include <numeric>
#include <set>

using namespace std;

class Solution {
public:
    int maxNiceDivisors(vector<int>& nums) {
        int n = nums.size();
        int ans = 0;
        for (int i = 0; i < (1 << (n - 1)); ++i) {
            int count = 0;
            vector<int> groups;
            int currentSum = nums[0];
            for (int j = 0; j < n - 1; ++j) {
                if ((i >> j) & 1) {
                    currentSum += nums[j + 1];
                } else {
                    groups.push_back(currentSum);
                    currentSum = nums[j + 1];
                }
            }
            groups.push_back(currentSum);

            set<int> distinctPrimes;
            for (int groupSum : groups) {
                vector<int> primes;
                int temp = groupSum;
                for (int j = 2; j * j <= temp; ++j) {
                    while (temp % j == 0) {
                        primes.push_back(j);
                        temp /= j;
                    }
                }
                if (temp > 1) {
                    primes.push_back(temp);
                }
                distinctPrimes.insert(primes.begin(), primes.end());
            }
            ans = max(ans, (int)distinctPrimes.size());
        }
        return ans;
    }
};