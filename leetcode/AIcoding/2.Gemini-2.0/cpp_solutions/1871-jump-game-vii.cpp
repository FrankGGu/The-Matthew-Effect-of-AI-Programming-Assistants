#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    bool canReach(string s, int minJump, int maxJump) {
        int n = s.size();
        vector<bool> visited(n, false);
        queue<int> q;
        q.push(0);
        visited[0] = true;

        while (!q.empty()) {
            int curr = q.front();
            q.pop();

            for (int next = curr + minJump; next <= min(curr + maxJump, n - 1); ++next) {
                if (s[next] == '0' && !visited[next]) {
                    if (next == n - 1) return true;
                    q.push(next);
                    visited[next] = true;
                }
            }
        }

        return false;
    }
};