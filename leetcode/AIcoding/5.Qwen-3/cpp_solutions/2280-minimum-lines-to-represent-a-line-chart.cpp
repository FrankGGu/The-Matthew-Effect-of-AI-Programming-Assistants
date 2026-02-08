#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minimumLines(vector<int>& coordinates) {
        if (coordinates.size() <= 1) return 0;
        int lines = 1;
        for (int i = 2; i < coordinates.size(); i += 2) {
            int x1 = coordinates[i - 2], y1 = coordinates[i - 1];
            int x2 = coordinates[i], y2 = coordinates[i + 1];
            int x3 = coordinates[i + 2], y3 = coordinates[i + 3];
            if ((y2 - y1) * (x3 - x2) != (y3 - y2) * (x2 - x1)) {
                lines++;
            }
        }
        return lines;
    }
};