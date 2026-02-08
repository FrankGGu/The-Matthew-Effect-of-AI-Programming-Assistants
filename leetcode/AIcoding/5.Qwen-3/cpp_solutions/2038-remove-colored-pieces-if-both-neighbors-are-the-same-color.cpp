#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool winnerOfGame(const string& colors) {
        int count = 0;
        for (int i = 1; i < colors.length() - 1; ++i) {
            if (colors[i] == colors[i - 1] && colors[i] == colors[i + 1]) {
                ++count;
            }
        }
        return count > 0;
    }
};