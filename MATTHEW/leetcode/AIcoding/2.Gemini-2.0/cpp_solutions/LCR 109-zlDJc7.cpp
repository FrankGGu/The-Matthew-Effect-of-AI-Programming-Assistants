#include <vector>
#include <queue>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int openLock(vector<string>& deadends, string target) {
        unordered_set<string> dead(deadends.begin(), deadends.end());
        if (dead.count("0000")) return -1;
        if (target == "0000") return 0;

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
                    string next1 = curr;
                    next1[j] = (next1[j] - '0' + 1) % 10 + '0';
                    string next2 = curr;
                    next2[j] = (next2[j] - '0' + 9) % 10 + '0';

                    if (!dead.count(next1) && !visited.count(next1)) {
                        q.push(next1);
                        visited.insert(next1);
                    }

                    if (!dead.count(next2) && !visited.count(next2)) {
                        q.push(next2);
                        visited.insert(next2);
                    }
                }
            }
            steps++;
        }

        return -1;
    }
};