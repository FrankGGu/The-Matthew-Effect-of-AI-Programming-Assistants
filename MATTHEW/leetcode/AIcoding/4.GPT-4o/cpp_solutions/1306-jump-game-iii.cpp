class Solution {
public:
    bool canReach(vector<int>& arr, int start) {
        int n = arr.size();
        vector<bool> visited(n, false);
        queue<int> q;
        q.push(start);

        while (!q.empty()) {
            int index = q.front();
            q.pop();
            if (index < 0 || index >= n || visited[index]) continue;
            if (arr[index] == 0) return true;
            visited[index] = true;
            q.push(index + arr[index]);
            q.push(index - arr[index]);
        }

        return false;
    }
};