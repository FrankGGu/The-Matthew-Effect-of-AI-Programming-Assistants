#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minimumJumps(vector<int>& forbidden, int a, int b, int x) {
        unordered_set<int> visited;
        unordered_set<int> forbidden_set(forbidden.begin(), forbidden.end());

        queue<pair<int, bool>> q;
        q.push({0, false});
        visited.insert(0);

        int steps = 0;
        int max_reach = max(x, *max_element(forbidden.begin(), forbidden.end())) + a + b;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int pos = q.front().first;
                bool went_back = q.front().second;
                q.pop();

                if (pos == x) {
                    return steps;
                }

                int forward = pos + a;
                if (forward <= max_reach && forbidden_set.find(forward) == forbidden_set.end() && visited.find(forward) == visited.end()) {
                    q.push({forward, false});
                    visited.insert(forward);
                }

                if (!went_back) {
                    int backward = pos - b;
                    if (backward >= 0 && forbidden_set.find(backward) == forbidden_set.end() && visited.find(backward) == visited.end()) {
                        q.push({backward, true});
                        visited.insert(backward);
                    }
                }
            }
            steps++;
        }

        return -1;
    }
};