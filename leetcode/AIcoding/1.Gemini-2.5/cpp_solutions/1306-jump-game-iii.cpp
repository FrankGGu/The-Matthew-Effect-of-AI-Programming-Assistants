#include <vector>
#include <queue>

class Solution {
public:
    bool canReach(std::vector<int>& arr, int start) {
        int n = arr.size();
        std::queue<int> q;
        std::vector<bool> visited(n, false);

        q.push(start);
        visited[start] = true;

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            if (arr[u] == 0) {
                return true;
            }

            int next_pos_forward = u + arr[u];
            if (next_pos_forward >= 0 && next_pos_forward < n && !visited[next_pos_forward]) {
                visited[next_pos_forward] = true;
                q.push(next_pos_forward);
            }

            int next_pos_backward = u - arr[u];
            if (next_pos_backward >= 0 && next_pos_backward < n && !visited[next_pos_backward]) {
                visited[next_pos_backward] = true;
                q.push(next_pos_backward);
            }
        }

        return false;
    }
};