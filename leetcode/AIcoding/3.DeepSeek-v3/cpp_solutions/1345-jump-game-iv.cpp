class Solution {
public:
    int minJumps(vector<int>& arr) {
        int n = arr.size();
        if (n == 1) return 0;

        unordered_map<int, vector<int>> valueIndices;
        for (int i = 0; i < n; ++i) {
            valueIndices[arr[i]].push_back(i);
        }

        vector<bool> visited(n, false);
        visited[0] = true;
        queue<int> q;
        q.push(0);
        int steps = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                int current = q.front();
                q.pop();

                if (current == n - 1) {
                    return steps;
                }

                vector<int>& neighbors = valueIndices[arr[current]];
                neighbors.push_back(current - 1);
                neighbors.push_back(current + 1);

                for (int neighbor : neighbors) {
                    if (neighbor >= 0 && neighbor < n && !visited[neighbor]) {
                        visited[neighbor] = true;
                        q.push(neighbor);
                    }
                }
                neighbors.clear();
            }
            steps++;
        }

        return -1;
    }
};