#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countPairs(vector<vector<int>>& points, int k) {
        unordered_map<int, int> count;
        int ans = 0;
        for (auto& p : points) {
            int x = p[0], y = p[1];
            for (int i = 0; i <= k; ++i) {
                int j = k - i;
                int target_x = x ^ i;
                int target_y = y ^ j;
                int hash_val = (target_x << 10) | target_y;
                if (count.count(hash_val)) {
                    ans += count[hash_val];
                }
            }
            int hash_val = (x << 10) | y;
            count[hash_val]++;
        }
        return ans;
    }
};