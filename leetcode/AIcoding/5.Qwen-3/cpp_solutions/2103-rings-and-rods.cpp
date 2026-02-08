#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countPoints(string rings) {
        vector<int> colorCount(3, 0);
        for (int i = 0; i < rings.length(); i += 2) {
            char color = rings[i];
            int index = rings[i + 1] - '0';
            if (color == 'R') {
                colorCount[0]++;
            } else if (color == 'G') {
                colorCount[1]++;
            } else if (color == 'B') {
                colorCount[2]++;
            }
        }
        int count = 0;
        for (int c : colorCount) {
            if (c >= 1) {
                count++;
            }
        }
        return count;
    }
};