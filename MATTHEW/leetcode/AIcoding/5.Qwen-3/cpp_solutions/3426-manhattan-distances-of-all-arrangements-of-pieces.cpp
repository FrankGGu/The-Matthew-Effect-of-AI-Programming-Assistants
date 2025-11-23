#include <iostream>
#include <vector>
#include <cmath>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int totalMoves(vector<vector<int>>& pieces, vector<vector<int>>& targets) {
        int n = pieces.size();
        vector<int> pos(n);
        for (int i = 0; i < n; ++i) {
            pos[i] = i;
        }

        unordered_map<string, int> memo;
        return dfs(pos, pieces, targets, memo);
    }

private:
    int dfs(vector<int>& pos, const vector<vector<int>>& pieces, const vector<vector<int>>& targets, unordered_map<string, int>& memo) {
        string key = "";
        for (int p : pos) {
            key += to_string(p) + ",";
        }

        if (memo.find(key) != memo.end()) {
            return memo[key];
        }

        int res = 0;
        bool allDone = true;
        for (int i = 0; i < pos.size(); ++i) {
            int pieceIndex = pos[i];
            int x1 = pieces[pieceIndex][0];
            int y1 = pieces[pieceIndex][1];
            int x2 = targets[i][0];
            int y2 = targets[i][1];
            if (x1 != x2 || y1 != y2) {
                allDone = false;
                break;
            }
        }

        if (allDone) {
            memo[key] = 0;
            return 0;
        }

        int minMoves = INT_MAX;
        for (int i = 0; i < pos.size(); ++i) {
            for (int j = i + 1; j < pos.size(); ++j) {
                swap(pos[i], pos[j]);
                int moves = abs(pieces[pos[i]][0] - targets[i][0]) + abs(pieces[pos[i]][1] - targets[i][1]) +
                            abs(pieces[pos[j]][0] - targets[j][0]) + abs(pieces[pos[j]][1] - targets[j][1]);
                int nextMoves = dfs(pos, pieces, targets, memo);
                minMoves = min(minMoves, moves + nextMoves);
                swap(pos[i], pos[j]);
            }
        }

        memo[key] = minMoves;
        return minMoves;
    }
};