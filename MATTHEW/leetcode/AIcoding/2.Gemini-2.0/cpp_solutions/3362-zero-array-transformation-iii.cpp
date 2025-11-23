#include <vector>

using namespace std;

class Solution {
public:
    bool canReach(vector<int>& arr, int start) {
        int n = arr.size();
        vector<bool> visited(n, false);
        vector<int> q;
        q.push_back(start);
        visited[start] = true;

        while (!q.empty()) {
            int u = q.front();
            q.erase(q.begin());

            if (arr[u] == 0) {
                return true;
            }

            int next1 = u + arr[u];
            if (next1 >= 0 && next1 < n && !visited[next1]) {
                q.push_back(next1);
                visited[next1] = true;
            }

            int next2 = u - arr[u];
            if (next2 >= 0 && next2 < n && !visited[next2]) {
                q.push_back(next2);
                visited[next2] = true;
            }
        }

        return false;
    }
};