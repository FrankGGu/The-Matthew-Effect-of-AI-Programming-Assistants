#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int minOperations(int n) {
        int operations = 0;
        while (n > 0) {
            if (n % 2 == 0) {
                n /= 2;
            } else {
                n = (n + 1) / 2;
                operations++;
            }
            operations++;
        }
        return operations - 1;
    }
};