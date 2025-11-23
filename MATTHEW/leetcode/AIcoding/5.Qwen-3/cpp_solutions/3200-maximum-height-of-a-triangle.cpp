#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxHeight(int n) {
        int height = 0;
        while (n > 0) {
            height++;
            n -= height;
        }
        return height;
    }
};