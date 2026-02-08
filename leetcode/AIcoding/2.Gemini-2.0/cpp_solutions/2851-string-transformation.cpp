#include <string>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int solve(string start, string end, vector<string>& bank) {
        unordered_set<string> visited;
        unordered_set<string> bankSet(bank.begin(), bank.end());

        if (start == end) return 0;
        if (bankSet.find(end) == bankSet.end()) return -1;

        queue<pair<string, int>> q;
        q.push({start, 0});
        visited.insert(start);

        while (!q.empty()) {
            string curr = q.front().first;
            int steps = q.front().second;
            q.pop();

            if (curr == end) return steps;

            for (int i = 0; i < curr.length(); ++i) {
                char originalChar = curr[i];
                for (char c = 'A'; c <= 'Z'; ++c) {
                    curr[i] = c;
                    if (bankSet.find(curr) != bankSet.end() && visited.find(curr) == visited.end()) {
                        q.push({curr, steps + 1});
                        visited.insert(curr);
                    }
                }
                curr[i] = originalChar;
            }
        }

        return -1;
    }
};