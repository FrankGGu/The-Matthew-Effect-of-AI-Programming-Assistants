#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int maximumSwap(int num) {
        vector<int> digits;
        int n = num;
        while (n > 0) {
            digits.push_back(n % 10);
            n /= 10;
        }
        for (int i = 0; i < digits.size(); ++i) {
            int maxDigit = digits[i];
            int maxIndex = i;
            for (int j = i + 1; j < digits.size(); ++j) {
                if (digits[j] > maxDigit) {
                    maxDigit = digits[j];
                    maxIndex = j;
                }
            }
            if (maxIndex != i) {
                swap(digits[i], digits[maxIndex]);
                break;
            }
        }
        int result = 0;
        for (int i = digits.size() - 1; i >= 0; --i) {
            result = result * 10 + digits[i];
        }
        return result;
    }
};