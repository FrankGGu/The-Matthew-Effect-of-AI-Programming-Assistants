#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int largestComponentSize(vector<int>& nums) {
        int n = nums.size();
        int max_val = *max_element(nums.begin(), nums.end());

        vector<int> parent(max_val + 1);
        iota(parent.begin(), parent.end(), 0);

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        auto unite = [&](int x, int y) {
            int root_x = find(x);
            int root_y = find(y);
            if (root_x != root_y) {
                parent[root_x] = root_y;
            }
        };

        for (int num : nums) {
            for (int i = 2; i * i <= num; ++i) {
                if (num % i == 0) {
                    unite(num, i);
                    unite(num, num / i);
                }
            }
        }

        vector<int> count(max_val + 1, 0);
        int ans = 0;
        for (int num : nums) {
            int root = find(num);
            count[root]++;
            ans = max(ans, count[root]);
        }

        return ans;
    }
};