#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberOfWays(int n, vector<vector<int>>& queries) {
        vector<int> prefix(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            prefix[i] = prefix[i - 1] + i;
        }

        vector<int> result;
        for (const auto& q : queries) {
            int a = q[0], b = q[1];
            if (a > b) swap(a, b);
            int count = prefix[b] - prefix[a];
            result.push_back(count);
        }

        return result.size();
    }
};