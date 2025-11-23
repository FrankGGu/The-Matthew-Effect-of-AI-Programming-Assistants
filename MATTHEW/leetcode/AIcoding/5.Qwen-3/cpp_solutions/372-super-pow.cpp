#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int superPow(int a, int b) {
        int result = 1;
        a = a % 10;
        for (int i = 0; i < b; i++) {
            result = (result * a) % 10;
        }
        return result;
    }
};