#include <string>
#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int kSimilarity(string s1, string s2) {
        if (s1 == s2) return 0;

        int n = s1.length();
        queue<pair<string, int>> q;
        unordered_set<string> visited;

        q.push({s1, 0});
        visited.insert(s1);

        while (!q.empty()) {
            string current = q.front().first;
            int steps = q.front().second;
            q.pop();

            if (current == s2) {
                return steps;
            }

            for (int i = 0; i < n; ++i) {
                if (current[i] != s2[i]) {
                    for (int j = i + 1; j < n; ++j) {
                        if (current[j] == s2[i] && current[j] != s2[j]) {
                            string next = current;
                            swap(next[i], next[j]);

                            if (visited.find(next) == visited.end()) {
                                q.push({next, steps + 1});
                                visited.insert(next);
                            }
                        }
                    }
                    break;
                }
            }
        }

        return -1;
    }
};