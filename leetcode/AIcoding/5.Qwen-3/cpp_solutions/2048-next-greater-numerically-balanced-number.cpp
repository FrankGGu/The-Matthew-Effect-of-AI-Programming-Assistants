#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int nextBeautifulNumber(int n) {
        vector<int> candidates = {1, 2, 3, 4, 5, 6};
        vector<vector<int>> validNumbers;

        for (int i = 1; i <= 6; ++i) {
            vector<int> digits;
            for (int j = 0; j < i; ++j) {
                digits.push_back(j + 1);
            }
            do {
                vector<int> count(7, 0);
                bool valid = true;
                for (int d : digits) {
                    count[d]++;
                }
                for (int d = 1; d <= 6; ++d) {
                    if (count[d] > 0 && count[d] != d) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    int num = 0;
                    for (int d : digits) {
                        num = num * 10 + d;
                    }
                    validNumbers.push_back(digits);
                }
            } while (next_permutation(digits.begin(), digits.end()));
        }

        sort(validNumbers.begin(), validNumbers.end());

        for (const auto& numDigits : validNumbers) {
            int num = 0;
            for (int d : numDigits) {
                num = num * 10 + d;
            }
            if (num > n) {
                return num;
            }
        }

        return -1;
    }
};