#include <iostream>
#include <string>

using namespace std;

class Solution {
public:
    int alternateDigitSum(int n) {
        int sum = 0;
        bool positive = true;
        while (n > 0) {
            int digit = n % 10;
            if (positive) {
                sum += digit;
            } else {
                sum -= digit;
            }
            positive = !positive;
            n /= 10;
        }
        return sum;
    }
};