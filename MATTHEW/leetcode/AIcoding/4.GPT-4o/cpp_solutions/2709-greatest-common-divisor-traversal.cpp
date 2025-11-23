class Solution {
public:
    vector<bool> gcdSort(vector<int>& nums) {
        int n = nums.size();
        vector<bool> result(n, false);
        vector<int> sorted_nums = nums;
        sort(sorted_nums.begin(), sorted_nums.end());

        UnionFind uf(n);
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (gcd(nums[i], nums[j]) > 1) {
                    uf.unionSet(i, j);
                }
            }
        }

        unordered_map<int, vector<int>> component_map;
        for (int i = 0; i < n; ++i) {
            component_map[uf.findSet(i)].push_back(i);
        }

        for (auto& [_, indices] : component_map) {
            vector<int> component_values;
            for (int index : indices) {
                component_values.push_back(nums[index]);
            }
            sort(component_values.begin(), component_values.end());
            for (int i = 0; i < indices.size(); ++i) {
                result[indices[i]] = (component_values[i] == sorted_nums[indices[i]]);
            }
        }

        return result;
    }

private:
    class UnionFind {
    public:
        UnionFind(int n) : parent(n), rank(n, 1) {
            for (int i = 0; i < n; ++i) {
                parent[i] = i;
            }
        }

        int findSet(int i) {
            if (parent[i] != i) {
                parent[i] = findSet(parent[i]);
            }
            return parent[i];
        }

        void unionSet(int i, int j) {
            int root_i = findSet(i);
            int root_j = findSet(j);
            if (root_i != root_j) {
                if (rank[root_i] > rank[root_j]) {
                    parent[root_j] = root_i;
                } else if (rank[root_i] < rank[root_j]) {
                    parent[root_i] = root_j;
                } else {
                    parent[root_j] = root_i;
                    rank[root_i]++;
                }
            }
        }

    private:
        vector<int> parent;
        vector<int> rank;
    };
};