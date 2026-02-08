#include <iostream>
#include <vector>
#include <map>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<vector<int>> points;
    unordered_map<int, unordered_map<int, int>> count;

    void add(int x, int y) {
        points.push_back({x, y});
        count[x][y]++;
    }

    int countSquares() {
        int result = 0;
        for (int i = 0; i < points.size(); ++i) {
            int x1 = points[i][0];
            int y1 = points[i][1];
            for (int j = 0; j < points.size(); ++j) {
                if (i == j) continue;
                int x2 = points[j][0];
                int y2 = points[j][1];
                if (x1 == x2 || y1 == y2) continue;
                int dx = x2 - x1;
                int dy = y2 - y1;
                int x3 = x1 + dy;
                int y3 = y1 - dx;
                int x4 = x2 + dy;
                int y4 = y2 - dx;
                result += count[x3][y3] * count[x4][y4];
            }
        }
        return result;
    }
};