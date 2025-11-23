#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    bool canReach(string s, int minJump, int maxJump) {
        int n = s.size();
        if (s[n - 1] == '1') return false;

        vector<bool> reachable(n, false);
        reachable[0] = true;

        queue<int> q;
        q.push(0);

        int furthest = 0;

        while (!q.empty()) {
            int curr = q.front();
            q.pop();

            int start = max(curr + minJump, furthest + 1);
            int end = min(curr + maxJump, n - 1);

            for (int i = start; i <= end; ++i) {
                if (s[i] == '0' && !reachable[i]) {
                    reachable[i] = true;
                    q.push(i);
                }
            }
            furthest = max(furthest, end);
        }

        return reachable[n - 1];
    }
};