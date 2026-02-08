class Solution {
public:
    vector<long long> maximumSegmentSum(vector<int>& nums, vector<int>& removeQueries) {
        int n = nums.size();
        vector<long long> res(n);
        vector<int> parent(n, -1);
        vector<long long> sum(n, 0);
        long long max_sum = 0;

        for (int i = n - 1; i >= 0; --i) {
            res[i] = max_sum;
            int pos = removeQueries[i];
            sum[pos] = nums[pos];
            if (pos > 0 && parent[pos - 1] != -1) {
                unite(pos, pos - 1, parent, sum);
            }
            if (pos < n - 1 && parent[pos + 1] != -1) {
                unite(pos, pos + 1, parent, sum);
            }
            int root = find(pos, parent);
            max_sum = max(max_sum, sum[root]);
        }

        return res;
    }

private:
    int find(int x, vector<int>& parent) {
        if (parent[x] == -1) {
            return x;
        }
        return parent[x] = find(parent[x], parent);
    }

    void unite(int x, int y, vector<int>& parent, vector<long long>& sum) {
        int rootX = find(x, parent);
        int rootY = find(y, parent);
        if (rootX != rootY) {
            parent[rootY] = rootX;
            sum[rootX] += sum[rootY];
        }
    }
};