#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    bool checkIfPossible(int n) {
        while (n > 0) {
            if (n % 3 == 2) return false;
            n /= 3;
        }
        return true;
    }
};