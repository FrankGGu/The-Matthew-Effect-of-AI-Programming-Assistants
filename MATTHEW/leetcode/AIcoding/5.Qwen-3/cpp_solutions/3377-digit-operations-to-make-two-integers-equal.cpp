#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int equalizeTwoNumbers(int a, int b) {
        int count = 0;
        while (a != b) {
            if (a > b) {
                a -= 1;
            } else {
                b -= 1;
            }
            count++;
        }
        return count;
    }
};