class Solution {
public:
    bool canReach(vector<int>& arr, int start) {
        int n = arr.size();
        vector<bool> visited(n, false);
        queue<int> q;
        q.push(start);
        visited[start] = true;

        while (!q.empty()) {
            int current = q.front();
            q.pop();

            if (arr[current] == 0) {
                return true;
            }

            int left = current - arr[current];
            if (left >= 0 && !visited[left]) {
                visited[left] = true;
                q.push(left);
            }

            int right = current + arr[current];
            if (right < n && !visited[right]) {
                visited[right] = true;
                q.push(right);
            }
        }

        return false;
    }
};