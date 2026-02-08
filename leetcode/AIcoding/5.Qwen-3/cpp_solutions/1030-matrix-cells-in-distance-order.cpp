#include <iostream>
#include <vector>
#include <queue>
#include <utility>

using namespace std;

class Solution {
public:
    vector<vector<int>> allCellsInOrder(int R, int C) {
        vector<vector<int>> result;
        vector<pair<int, int>> cells;

        for (int r = 0; r < R; ++r) {
            for (int c = 0; c < C; ++c) {
                cells.push_back({r, c});
            }
        }

        auto compare = [&](const pair<int, int>& a, const pair<int, int>& b) {
            int distA = abs(a.first) + abs(a.second);
            int distB = abs(b.first) + abs(b.second);
            return distA > distB;
        };

        priority_queue<pair<int, int>, vector<pair<int, int>>, decltype(compare)> pq(compare);

        for (const auto& cell : cells) {
            pq.push(cell);
        }

        while (!pq.empty()) {
            auto cell = pq.top();
            result.push_back({cell.first, cell.second});
            pq.pop();
        }

        return result;
    }
};