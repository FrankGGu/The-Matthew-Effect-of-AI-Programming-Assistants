#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int clumsy(int n) {
        if (n == 1) return 1;
        if (n == 2) return 2;
        if (n == 3) return 6;
        int result = n;
        for (int i = n - 1; i > 0; i -= 4) {
            if (i - 1 >= 1) result -= i - 1;
            if (i - 2 >= 1) result *= i - 2;
            if (i - 3 >= 1) result /= i - 3;
        }
        return result;
    }
};