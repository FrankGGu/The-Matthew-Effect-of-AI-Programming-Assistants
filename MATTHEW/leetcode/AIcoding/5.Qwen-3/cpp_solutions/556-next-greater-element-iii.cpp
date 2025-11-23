#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int nextGreaterElement(int n) {
        vector<int> digits;
        while (n > 0) {
            digits.push_back(n % 10);
            n /= 10;
        }
        reverse(digits.begin(), digits.end());

        int i = digits.size() - 2;
        while (i >= 0 && digits[i] >= digits[i + 1]) {
            i--;
        }

        if (i < 0) {
            return -1;
        }

        int j = digits.size() - 1;
        while (digits[j] <= digits[i]) {
            j--;
        }

        swap(digits[i], digits[j]);

        reverse(digits.begin() + i + 1, digits.end());

        long result = 0;
        for (int d : digits) {
            result = result * 10 + d;
        }

        return result > INT_MAX ? -1 : static_cast<int>(result);
    }
};