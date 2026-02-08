#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfBoomerangs(vector<vector<int>>& points) {
        int result = 0;
        for (const auto& p : points) {
            unordered_map<int, int> distCount;
            for (const auto& q : points) {
                if (p == q) continue;
                int dx = p[0] - q[0];
                int dy = p[1] - q[1];
                int dist = dx * dx + dy * dy;
                distCount[dist]++;
            }
            for (const auto& count : distCount) {
                result += count.second * (count.second - 1);
            }
        }
        return result;
    }
};