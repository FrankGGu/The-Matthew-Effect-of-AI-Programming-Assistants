#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int minimumPerimeter(long long needed) {
        long long n = 1;
        while (true) {
            long long apples = (n * (n + 1) / 2) * (n * (n + 1) / 2);
            if (apples >= needed) {
                return n * 8;
            }
            n++;
        }
    }
};