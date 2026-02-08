#include <iostream>
#include <vector>
#include <unordered_map>
#include <utility>

using namespace std;

class Solution {
public:
    int overlap(vector<vector<int>>& img1, vector<vector<int>>& img2) {
        int n = img1.size();
        vector<pair<int, int>> ones1, ones2;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (img1[i][j] == 1) {
                    ones1.push_back({i, j});
                }
                if (img2[i][j] == 1) {
                    ones2.push_back({i, j});
                }
            }
        }

        unordered_map<int, int> diffCount;
        int maxOverlap = 0;

        for (auto [x1, y1] : ones1) {
            for (auto [x2, y2] : ones2) {
                int dx = x1 - x2;
                int dy = y1 - y2;
                int key = dx * 1000 + dy;                 diffCount[key]++;
                maxOverlap = max(maxOverlap, diffCount[key]);
            }
        }

        return maxOverlap;
    }
};