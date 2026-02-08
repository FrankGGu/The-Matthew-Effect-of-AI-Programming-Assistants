#include <vector>
#include <queue>
#include <set>

using namespace std;

class Solution {
public:
    vector<int> minReverseOperations(int n, int p, vector<int>& banned, int k) {
        vector<int> ans(n, -1);
        set<int> visited = {p};
        for (int b : banned) {
            visited.insert(b);
        }

        queue<int> q;
        q.push(p);
        ans[p] = 0;

        while (!q.empty()) {
            int curr = q.front();
            q.pop();

            for (int i = 0; i < n; ++i) {
                int left = curr - (k - 1 - (abs(curr - i)));
                if (left < 0) continue;

                int right = curr + (k - 1 - (abs(curr - i)));
                if (right >= n) continue;

                if (abs(curr - i) > k - 1) continue;
                if (abs(curr - i) % 2 != (k - 1) % 2) continue;

                int j = i;
                if (ans[j] == -1 && visited.find(j) == visited.end()) {
                    ans[j] = ans[curr] + 1;
                    visited.insert(j);
                    q.push(j);
                }

            }
        }

        return ans;
    }
};