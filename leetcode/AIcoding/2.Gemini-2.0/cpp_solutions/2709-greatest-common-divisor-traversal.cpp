#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool canTraverseAllPairs(vector<int>& nums) {
        int n = nums.size();
        if (n == 1) return true;

        int mx = *max_element(nums.begin(), nums.end());
        vector<int> parent(mx + 1);
        for (int i = 0; i <= mx; ++i) {
            parent[i] = i;
        }

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        auto unite = [&](int x, int y) {
            x = find(x);
            y = find(y);
            if (x != y) {
                parent[x] = y;
            }
        };

        vector<bool> visited(mx + 1, false);

        for (int num : nums) {
            if (num == 1) return false;
            for (int i = 2; i * i <= num; ++i) {
                if (num % i == 0) {
                    if (!visited[i]) {
                        visited[i] = true;
                    }
                    unite(nums[0], i);
                    while (num % i == 0) {
                        num /= i;
                    }
                }
            }
            if (num > 1) {
                if (!visited[num]) {
                    visited[num] = true;
                }
                unite(nums[0], num);
            }
        }

        int root = find(nums[0]);
        for (int i = 1; i < n; ++i) {
            if (find(nums[i]) != root) {
                return false;
            }
        }

        return true;
    }
};