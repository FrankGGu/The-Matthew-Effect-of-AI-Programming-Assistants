#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long sumOfDigitDifferences(vector<int>& nums) {
        int n = nums.size();
        long long result = 0;

        for (int i = 0; i < n; ++i) {
            vector<int> digits1(10, 0);
            for (int j = i + 1; j < n; ++j) {
                vector<int> digits2(10, 0);
                int num1 = nums[i];
                int num2 = nums[j];

                while (num1 > 0) {
                    digits1[num1 % 10]++;
                    num1 /= 10;
                }

                while (num2 > 0) {
                    digits2[num2 % 10]++;
                    num2 /= 10;
                }

                int diff = 0;
                for (int k = 0; k < 10; ++k) {
                    if (digits1[k] != digits2[k]) {
                        diff++;
                    }
                }
                result += diff;
            }
        }

        return result;
    }
};