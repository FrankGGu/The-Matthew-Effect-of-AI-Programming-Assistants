#include <vector>
#include <string>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int openLock(vector<string>& deadends, string target) {
        unordered_set<string> dead(deadends.begin(), deadends.end());
        if (dead.find("0000") != dead.end()) {
            return -1;
        }
        if (target == "0000") {
            return 0;
        }

        unordered_set<string> visited;
        visited.insert("0000");
        queue<string> q;
        q.push("0000");
        int steps = 0;

        while (!q.empty()) {
            steps++;
            int size = q.size();
            for (int i = 0; i < size; i++) {
                string current = q.front();
                q.pop();
                for (int j = 0; j < 4; j++) {
                    for (int k = -1; k <= 1; k += 2) {
                        string next = current;
                        next[j] = (current[j] - '0' + k + 10) % 10 + '0';
                        if (next == target) {
                            return steps;
                        }
                        if (dead.find(next) == dead.end() && visited.find(next) == visited.end()) {
                            visited.insert(next);
                            q.push(next);
                        }
                    }
                }
            }
        }
        return -1;
    }
};