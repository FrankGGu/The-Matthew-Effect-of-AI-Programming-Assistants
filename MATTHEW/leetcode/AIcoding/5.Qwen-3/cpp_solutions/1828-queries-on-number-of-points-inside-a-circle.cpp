#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<int> countPoints(vector<vector<int>>& points, vector<vector<int>>& queries) {
        vector<int> result;
        for (const auto& q : queries) {
            int x = q[0], y = q[1], r = q[2];
            int count = 0;
            for (const auto& p : points) {
                int dx = p[0] - x;
                int dy = p[1] - y;
                if (dx * dx + dy * dy <= r * r) {
                    ++count;
                }
            }
            result.push_back(count);
        }
        return result;
    }
};