class Solution {
public:
    vector<bool> blockPlacementQueries(int n, vector<vector<int>>& queries) {
        vector<bool> res;
        vector<int> parent(n + 2);
        vector<int> size(n + 2, 1);
        for (int i = 0; i < n + 2; ++i) {
            parent[i] = i;
        }

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        for (auto& q : queries) {
            if (q[0] == 1) {
                int x = q[1];
                parent[x] = x + 1;
            } else {
                int x = q[1], y = q[2];
                res.push_back(find(x) >= y);
            }
        }
        return res;
    }
};