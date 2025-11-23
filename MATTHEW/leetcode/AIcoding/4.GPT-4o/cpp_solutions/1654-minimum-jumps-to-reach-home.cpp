#include <vector>
#include <queue>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minimumJumps(vector<int>& forbidden, int a, int b, int x) {
        unordered_set<int> forbiddenSet(forbidden.begin(), forbidden.end());
        queue<pair<int, int>> q; // position, last jump type (0 for forward, 1 for backward)
        q.push({0, 0});
        forbiddenSet.insert(0);
        int steps = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto [pos, lastJump] = q.front();
                q.pop();

                if (pos == x) return steps;

                int forward = pos + a;
                if (forward <= 6000 && !forbiddenSet.count(forward)) {
                    forbiddenSet.insert(forward);
                    q.push({forward, 0});
                }

                if (lastJump == 0) {
                    int backward = pos - b;
                    if (backward >= 0 && !forbiddenSet.count(backward)) {
                        forbiddenSet.insert(backward);
                        q.push({backward, 1});
                    }
                }
            }
            ++steps;
        }
        return -1;
    }
};