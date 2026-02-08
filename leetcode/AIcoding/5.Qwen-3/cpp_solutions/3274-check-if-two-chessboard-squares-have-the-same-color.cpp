#include <iostream>
#include <string>

using namespace std;

class Solution {
public:
    bool squareIsWhite(int x, int y) {
        return (x + y) % 2 == 1;
    }
};