#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<long long> maximumSegmentSum(std::vector<int>& nums, std::vector<int>& removeQueries) {
        int n = nums.size();
        parent.resize(n);
        std::iota(parent.begin(), parent.end(), 0);
        sum.assign(n, 0);

        std::vector<long long> ans(n);
        std::vector<bool> active(n, false);
        long long max_sum = 0;

        for (int i = n - 1; i >= 0; --i) {
            ans[i] = max_sum;
            int idx = removeQueries[i];

            active[idx] = true;
            sum[idx] = nums[idx];

            if (idx > 0 && active[idx - 1]) {
                unite(idx, idx - 1);
            }
            if (idx < n - 1 && active[idx + 1]) {
                unite(idx, idx + 1);
            }

            max_sum = std::max(max_sum, sum[find(idx)]);
        }
        return ans;
    }

private:
    std::vector<int> parent;
    std::vector<long long> sum;

    int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    void unite(int i, int j) {
        int root_i = find(i);
        int root_j = find(j);
        if (root_i != root_j) {
            parent[root_j] = root_i;
            sum[root_i] += sum[root_j];
        }
    }
};