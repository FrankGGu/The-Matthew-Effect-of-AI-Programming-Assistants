#include <vector>
#include <string>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int openLock(vector<string>& deadends, string target) {
        unordered_set<string> dead(deadends.begin(), deadends.end());
        if (dead.count("0000")) return -1;

        queue<string> q;
        q.push("0000");
        unordered_set<string> visited;
        visited.insert("0000");
        int steps = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                string curr = q.front();
                q.pop();
                if (curr == target) return steps;

                for (int j = 0; j < 4; ++j) {
                    for (int d = -1; d <= 1; d += 2) {
                        string next = curr;
                        next[j] = (next[j] - '0' + d + 10) % 10 + '0';
                        if (!dead.count(next) && !visited.count(next)) {
                            visited.insert(next);
                            q.push(next);
                        }
                    }
                }
            }
            ++steps;
        }
        return -1;
    }
};