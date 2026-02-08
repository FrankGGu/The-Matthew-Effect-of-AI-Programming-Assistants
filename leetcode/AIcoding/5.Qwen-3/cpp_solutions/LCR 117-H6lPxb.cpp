#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>
#include <queue>

using namespace std;

class Solution {
public:
    int numSimilarGroups(vector<string>& strs) {
        int n = strs.size();
        vector<bool> visited(n, false);
        int groups = 0;

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                ++groups;
                queue<int> q;
                q.push(i);
                visited[i] = true;

                while (!q.empty()) {
                    int curr = q.front();
                    q.pop();

                    for (int j = 0; j < n; ++j) {
                        if (!visited[j] && areSimilar(strs[curr], strs[j])) {
                            visited[j] = true;
                            q.push(j);
                        }
                    }
                }
            }
        }

        return groups;
    }

private:
    bool areSimilar(const string& a, const string& b) {
        int diff = 0;
        for (int i = 0; i < a.size() && diff <= 2; ++i) {
            if (a[i] != b[i]) {
                ++diff;
            }
        }
        return diff == 2 || diff == 0;
    }
};