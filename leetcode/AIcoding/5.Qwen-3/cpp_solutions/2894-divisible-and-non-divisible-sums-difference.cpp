#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int differenceOfSums(int num, int m) {
        int sum = 0;
        for (int i = 1; i <= num; ++i) {
            if (i % m != 0) {
                sum += i;
            }
        }
        return sum;
    }
};