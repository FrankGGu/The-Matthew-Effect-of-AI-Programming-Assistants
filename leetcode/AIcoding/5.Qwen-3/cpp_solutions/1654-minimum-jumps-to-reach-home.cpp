#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minJumpSquares(vector<int>& forbidden, int a, int b, int start = 0, int end = 100000) {
        queue<pair<int, int>> q;
        unordered_set<int> visited;
        q.push({start, 0});
        visited.insert(start);

        int max_pos = end + a + b;

        while (!q.empty()) {
            auto [pos, jumps] = q.front();
            q.pop();

            if (pos == end) {
                return jumps;
            }

            vector<int> next_positions;
            next_positions.push_back(pos + a);
            next_positions.push_back(pos - b);

            for (int next : next_positions) {
                if (next >= 0 && next <= max_pos && visited.find(next) == visited.end() && find(forbidden.begin(), forbidden.end(), next) == forbidden.end()) {
                    visited.insert(next);
                    q.push({next, jumps + 1});
                }
            }
        }

        return -1;
    }
};