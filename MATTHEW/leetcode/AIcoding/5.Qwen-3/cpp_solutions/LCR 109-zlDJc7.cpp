#include <iostream>
#include <vector>
#include <queue>
#include <unordered_set>
#include <string>

using namespace std;

class Solution {
public:
    int openLock(vector<string>& deadends, string target) {
        unordered_set<string> dead(deadends.begin(), deadends.end());
        if (target == "0000") return 0;
        if (dead.count("0000")) return -1;

        queue<pair<string, int>> q;
        q.push({"0000", 0});
        unordered_set<string> visited = {"0000"};

        while (!q.empty()) {
            auto [current, steps] = q.front();
            q.pop();

            for (int i = 0; i < 4; ++i) {
                for (int delta : {-1, 1}) {
                    string next = current;
                    next[i] = ((next[i] - '0') + delta + 10) % 10 + '0';
                    if (next == target) return steps + 1;
                    if (!visited.count(next) && !dead.count(next)) {
                        visited.insert(next);
                        q.push({next, steps + 1});
                    }
                }
            }
        }

        return -1;
    }
};