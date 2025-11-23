#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int minimumOperationsToMakeInteger(int num, int target) {
        int operations = 0;
        while (num != target) {
            if (num > target) {
                num -= 1;
            } else {
                num += 1;
            }
            operations++;
        }
        return operations;
    }
};