#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int guardWall(vector<int>& guards, vector<int>& walls) {
        sort(guards.begin(), guards.end());
        sort(walls.begin(), walls.end());

        int g = 0, w = 0;
        int count = 0;

        while (g < guards.size() && w < walls.size()) {
            if (guards[g] < walls[w]) {
                count++;
                g++;
            } else {
                w++;
            }
        }

        return count;
    }
};