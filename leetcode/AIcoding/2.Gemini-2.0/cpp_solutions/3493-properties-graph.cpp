#include <vector>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int largestComponentSize(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> parent;
        unordered_map<int, int> rank;

        function<int(int)> find = [&](int x) {
            if (parent.find(x) == parent.end()) {
                parent[x] = x;
                rank[x] = 1;
                return x;
            }
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        function<void(int, int)> unite = [&](int x, int y) {
            x = find(x);
            y = find(y);
            if (x != y) {
                if (rank[x] < rank[y]) {
                    swap(x, y);
                }
                parent[y] = x;
                if (rank[x] == rank[y]) {
                    rank[x]++;
                }
            }
        };

        for (int num : nums) {
            for (int i = 2; i * i <= num; ++i) {
                if (num % i == 0) {
                    unite(num, i);
                    while (num % i == 0) {
                        num /= i;
                    }
                }
            }
            if (num > 1) {
                unite(num, nums[0]);
            }
        }

        unordered_map<int, int> componentSize;
        int maxSize = 0;
        for (int num : nums) {
            int root = find(num);
            componentSize[root]++;
            maxSize = max(maxSize, componentSize[root]);
        }

        return maxSize;
    }
};