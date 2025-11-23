#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    bool reachingPoints(int sx, int sy, int dx, int dy) {
        while (dx >= sx && dy >= sy) {
            if (dx == sx && dy == sy) return true;
            if (dx > dy) {
                if (dy > sy) dx = dx % dy;
                else break;
            } else {
                if (dx > sx) dy = dy % dx;
                else break;
            }
        }
        return false;
    }
};