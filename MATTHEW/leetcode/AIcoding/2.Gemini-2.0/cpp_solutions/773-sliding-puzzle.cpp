#include <vector>
#include <queue>
#include <string>
#include <unordered_set>

using namespace std;

int slidingPuzzle(vector<vector<int>>& board) {
    string target = "123450";
    string initial = "";
    for (int i = 0; i < 2; ++i) {
        for (int j = 0; j < 3; ++j) {
            initial += to_string(board[i][j]);
        }
    }

    queue<pair<string, int>> q;
    unordered_set<string> visited;
    q.push({initial, 0});
    visited.insert(initial);

    vector<vector<int>> neighbors = {{1, 3}, {0, 2, 4}, {1, 5}, {0, 4}, {1, 3, 5}, {2, 4}};

    while (!q.empty()) {
        string current = q.front().first;
        int steps = q.front().second;
        q.pop();

        if (current == target) {
            return steps;
        }

        int zeroIndex = current.find('0');
        for (int neighbor : neighbors[zeroIndex]) {
            string next = current;
            swap(next[zeroIndex], next[neighbor]);
            if (visited.find(next) == visited.end()) {
                q.push({next, steps + 1});
                visited.insert(next);
            }
        }
    }

    return -1;
}