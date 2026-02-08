#include <vector>

class Solution {
public:
    bool isNoZero(int num) {
        while (num > 0) {
            if (num % 10 == 0) {
                return false;
            }
            num /= 10;
        }
        return true;
    }

    std::vector<int> getNoZeroIntegers(int n) {
        for (int A = 1; A < n; ++A) {
            int B = n - A;
            if (isNoZero(A) && isNoZero(B)) {
                return {A, B};
            }
        }
        return {}; 
    }
};