#include <iostream>
#include <vector>
#include <numeric>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> findValidSplit(int n, vector<int>& nums) {
        vector<int> result;
        unordered_map<int, int> primeCount;
        for (int i = 0; i < n; ++i) {
            int num = nums[i];
            for (int p = 2; p * p <= num; ++p) {
                while (num % p == 0) {
                    primeCount[p]++;
                    num /= p;
                }
            }
            if (num > 1) {
                primeCount[num]++;
            }
        }

        unordered_map<int, int> leftPrimeCount;
        int left = 0;
        for (int right = 0; right < n; ++right) {
            int num = nums[right];
            for (int p = 2; p * p <= num; ++p) {
                while (num % p == 0) {
                    leftPrimeCount[p]++;
                    num /= p;
                }
            }
            if (num > 1) {
                leftPrimeCount[num]++;
            }

            bool valid = true;
            for (auto& [p, count] : leftPrimeCount) {
                if (count != primeCount[p]) {
                    valid = false;
                    break;
                }
            }

            if (valid) {
                result.push_back(right);
                left = right + 1;
                leftPrimeCount.clear();
            }
        }

        return result;
    }
};