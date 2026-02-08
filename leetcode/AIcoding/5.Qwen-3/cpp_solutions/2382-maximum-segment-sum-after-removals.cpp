#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maximumSegmentSum(vector<int>& nums, vector<int>& removeQueries) {
        int n = nums.size();
        vector<long long> result(n);
        unordered_map<int, long long> parent;
        unordered_map<int, long long> sum;

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        function<void(int, int)> unionSet = [&](int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootY] = rootX;
                sum[rootX] += sum[rootY];
            }
        };

        for (int i = 0; i < n; ++i) {
            parent[i] = i;
            sum[i] = nums[i];
        }

        for (int i = n - 1; i >= 0; --i) {
            int index = removeQueries[i];
            sum[index] = nums[index];
            parent[index] = index;
            if (index + 1 < n && parent.find(index + 1) != parent.end()) {
                unionSet(index, index + 1);
            }
            if (index - 1 >= 0 && parent.find(index - 1) != parent.end()) {
                unionSet(index, index - 1);
            }
            result[i] = sum[find(index)];
        }

        reverse(result.begin(), result.end());
        return result[0];
    }
};