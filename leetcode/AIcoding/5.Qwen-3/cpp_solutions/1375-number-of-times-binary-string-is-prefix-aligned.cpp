#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int hasPrefixAtLeast(int n, vector<int>& flips) {
        int maxIndex = 0;
        int count = 0;
        for (int i = 0; i < n; ++i) {
            maxIndex = max(maxIndex, flips[i]);
            if (maxIndex == i + 1) {
                ++count;
            }
        }
        return count;
    }
};