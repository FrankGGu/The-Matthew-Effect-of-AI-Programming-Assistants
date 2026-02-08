#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int mirrorReflection(int p, int q) {
        int m = p, n = q;
        while (n) {
            int temp = n;
            n = m % n;
            m = temp;
        }
        int lcm = p * q / m;
        int a = lcm / p;
        int b = lcm / q;
        if (a % 2 == 0) return 2;
        if (b % 2 == 0) return 1;
        return 0;
    }
};