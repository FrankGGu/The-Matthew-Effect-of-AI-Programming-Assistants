#include <vector>
#include <unordered_set>
#include <string>
#include <utility>

using namespace std;

class Solution {
public:
    unordered_set<string> black;
    unordered_set<string> white;
    vector<vector<int>> dirs = {{0, 1}, {1, 0}, {1, 1}, {1, -1}};

    string move(vector<int> res) {
        return to_string(res[0]) + "," + to_string(res[1]);
    }

    vector<int> checkWin(unordered_set<string>& stones, int r, int c) {
        for (auto& dir : dirs) {
            int count = 1;
            int dr = dir[0], dc = dir[1];
            int nr = r + dr, nc = c + dc;
            while (stones.find(move({nr, nc})) {
                count++;
                nr += dr;
                nc += dc;
            }
            nr = r - dr;
            nc = c - dc;
            while (stones.find(move({nr, nc}))) {
                count++;
                nr -= dr;
                nc -= dc;
            }
            if (count >= 5) return {r, c};
        }
        return {};
    }

    vector<int> move(vector<vector<int>>& steps) {
        for (int i = 0; i < steps.size(); ++i) {
            int r = steps[i][0], c = steps[i][1];
            if (i % 2 == 0) {
                black.insert(move({r, c}));
                vector<int> res = checkWin(black, r, c);
                if (!res.empty()) return res;
            } else {
                white.insert(move({r, c}));
                vector<int> res = checkWin(white, r, c);
                if (!res.empty()) return res;
            }
        }
        return {};
    }
};