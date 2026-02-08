#include <vector>

using namespace std;

class Solution {
public:
    vector<int> productQueries(int n, vector<vector<int>>& queries) {
        vector<int> powers;
        for (int i = 0; i < 31; ++i) {
            if ((n >> i) & 1) {
                powers.push_back(1 << i);
            }
        }

        vector<int> result;
        long long mod = 1e9 + 7;

        for (auto& query : queries) {
            int left = query[0];
            int right = query[1];
            long long product = 1;
            for (int i = left; i <= right; ++i) {
                product = (product * powers[i]) % mod;
            }
            result.push_back(product);
        }

        return result;
    }
};