class Solution {
public:
    vector<int> processQueries(vector<vector<int>>& restrictions, vector<int>& requests) {
        int n = requests.size();
        vector<int> result(n, 0);
        vector<int> parent(1001);
        iota(parent.begin(), parent.end(), 0);

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        for (auto& r : restrictions) {
            int u = find(r[0]), v = find(r[1]);
            if (u != v) {
                parent[u] = v;
            }
        }

        vector<int> count(1001, 0);
        for (int i = 0; i < n; ++i) {
            int req = requests[i];
            if (count[find(req)] == 0) {
                count[find(req)]++;
                result[i] = 1;
            }
        }

        return result;
    }
};