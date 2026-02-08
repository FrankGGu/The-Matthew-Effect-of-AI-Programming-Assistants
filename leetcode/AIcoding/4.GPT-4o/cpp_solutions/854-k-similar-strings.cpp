#include <string>
#include <queue>
#include <unordered_set>
#include <vector>

using namespace std;

class Solution {
public:
    int kSimilarity(string A, string B) {
        if (A == B) return 0;
        queue<string> q;
        unordered_set<string> visited;
        q.push(A);
        visited.insert(A);
        int steps = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; i++) {
                string curr = q.front(); q.pop();
                if (curr == B) return steps;

                for (int j = 0; j < curr.size(); j++) {
                    if (curr[j] == B[j]) continue;
                    for (int k = j + 1; k < curr.size(); k++) {
                        if (curr[k] == B[j] && curr[k] != B[k]) {
                            swap(curr[j], curr[k]);
                            if (visited.find(curr) == visited.end()) {
                                visited.insert(curr);
                                q.push(curr);
                            }
                            swap(curr[j], curr[k]); // backtrack
                        }
                    }
                    break; // only need to swap once per mismatch
                }
            }
            steps++;
        }
        return -1; // should never reach here
    }
};