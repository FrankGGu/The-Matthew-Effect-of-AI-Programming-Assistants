#include <vector>
#include <algorithm>

using namespace std;

class DSU {
public:
    vector<int> parent;
    DSU(int n) : parent(n) {
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }
    }

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unite(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            parent[rootX] = rootY;
        }
    }
};

vector<int> lexicographicallySmallestArray(vector<int>& nums, int limit) {
    int n = nums.size();
    DSU dsu(n);

    for (int i = 0; i < n; ++i) {
        for (int j = i + 1; j < n; ++j) {
            if (abs(nums[i] - nums[j]) <= limit) {
                dsu.unite(i, j);
            }
        }
    }

    vector<vector<int>> groups(n);
    for (int i = 0; i < n; ++i) {
        groups[dsu.find(i)].push_back(i);
    }

    vector<int> ans = nums;
    for (int i = 0; i < n; ++i) {
        if (groups[i].empty()) continue;
        vector<int> indices = groups[i];
        vector<int> values;
        for (int index : indices) {
            values.push_back(nums[index]);
        }
        sort(indices.begin(), indices.end());
        sort(values.begin(), values.end());

        for (size_t j = 0; j < indices.size(); ++j) {
            ans[indices[j]] = values[j];
        }
    }

    return ans;
}