#include <vector>
#include <unordered_set>
#include <cmath>

using namespace std;

class Solution {
public:
    int distinctPrimeFactors(vector<int>& nums) {
        unordered_set<int> primes;
        for (int num : nums) {
            for (int i = 2; i * i <= num; ++i) {
                while (num % i == 0) {
                    primes.insert(i);
                    num /= i;
                }
            }
            if (num > 1) {
                primes.insert(num);
            }
        }
        return primes.size();
    }

    int splitNum(int num) {
        vector<int> digits;
        while (num > 0) {
            digits.push_back(num % 10);
            num /= 10;
        }
        sort(digits.begin(), digits.end());
        int num1 = 0, num2 = 0;
        for (int i = 0; i < digits.size(); ++i) {
            if (i % 2 == 0) {
                num1 = num1 * 10 + digits[i];
            } else {
                num2 = num2 * 10 + digits[i];
            }
        }
        return num1 + num2;
    }

    int maximizeDistinctPrimeFactors(vector<int>& nums) {
        int maxDistinct = 0;
        for (int i = 0; i < (1 << nums.size()); ++i) {
            vector<int> splitNums;
            for (int j = 0; j < nums.size(); ++j) {
                if (i & (1 << j)) {
                    int split = splitNum(nums[j]);
                    if (split != nums[j]) {
                        splitNums.push_back(split);
                    } else {
                        splitNums.push_back(nums[j]);
                    }
                } else {
                    splitNums.push_back(nums[j]);
                }
            }
            int current = distinctPrimeFactors(splitNums);
            if (current > maxDistinct) {
                maxDistinct = current;
            }
        }
        return maxDistinct;
    }
};