#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minimumRecolors(const string& blocks, int k) {
        int n = blocks.length();
        int minRecolors = k;
        int currentRecolors = 0;

        for (int i = 0; i < k; ++i) {
            if (blocks[i] == 'B') {
                currentRecolors++;
            }
        }

        minRecolors = k - currentRecolors;

        for (int i = k; i < n; ++i) {
            if (blocks[i - k] == 'B') {
                currentRecolors--;
            }
            if (blocks[i] == 'B') {
                currentRecolors++;
            }
            minRecolors = min(minRecolors, k - currentRecolors);
        }

        return minRecolors;
    }
};