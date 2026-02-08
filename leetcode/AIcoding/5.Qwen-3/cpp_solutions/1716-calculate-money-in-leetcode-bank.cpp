#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int totalMoney(int n) {
        int total = 0;
        int week = 0;
        while (n > 0) {
            int start = 1 + week;
            for (int i = 0; i < 7 && n > 0; i++) {
                total += start + i;
                n--;
            }
            week++;
        }
        return total;
    }
};