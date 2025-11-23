class Solution {
public:
    vector<int> maxGeneticDifference(vector<int>& parents, vector<vector<int>>& queries) {
        int n = parents.size();
        vector<int> result;
        vector<int> depth(n, -1);
        vector<int> max_genetic(n, 0);

        for (int i = 0; i < n; ++i) {
            if (depth[i] == -1) {
                int cur = i, d = 0;
                while (cur != -1 && depth[cur] == -1) {
                    depth[cur] = d++;
                    cur = parents[cur];
                }
                if (cur != -1) {
                    max_genetic[i] = depth[i] - depth[cur];
                }
            }
        }

        for (const auto& query : queries) {
            int x = query[0], y = query[1];
            result.push_back(max_genetic[x] ^ max_genetic[y]);
        }

        return result;
    }
};