#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int countNumbersWithUniqueDigits(int n) {
        if (n == 0) return 1;
        if (n > 10) n = 10;
        int result = 10;
        int uniqueDigits = 9;
        int availableDigits = 9;
        for (int i = 1; i < n; ++i) {
            uniqueDigits *= availableDigits;
            result += uniqueDigits;
            --availableDigits;
        }
        return result;
    }
};