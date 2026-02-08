class Solution {
public:
    vector<int> countPairs(int n, vector<vector<int>>& edges, vector<int>& queries) {
        vector<int> degree(n + 1, 0);
        unordered_map<int, unordered_map<int, int>> shared;

        for (auto& e : edges) {
            int u = min(e[0], e[1]);
            int v = max(e[0], e[1]);
            degree[u]++;
            degree[v]++;
            shared[u][v]++;
        }

        vector<int> sorted_degree(degree.begin() + 1, degree.end());
        sort(sorted_degree.begin(), sorted_degree.end());

        vector<int> res;
        for (int q : queries) {
            int cnt = 0;
            int left = 0, right = n - 1;
            while (left < right) {
                if (sorted_degree[left] + sorted_degree[right] > q) {
                    cnt += right - left;
                    right--;
                } else {
                    left++;
                }
            }

            for (auto& it : shared) {
                int u = it.first;
                for (auto& jt : it.second) {
                    int v = jt.first;
                    int total = degree[u] + degree[v] - jt.second;
                    if (degree[u] + degree[v] > q && total <= q) {
                        cnt--;
                    }
                }
            }
            res.push_back(cnt);
        }
        return res;
    }
};