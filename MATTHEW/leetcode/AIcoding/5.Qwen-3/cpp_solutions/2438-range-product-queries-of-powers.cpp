#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<long long> rangeProductQueries(int n, vector<vector<int>>& queries) {
        int size = 1 << n;
        vector<long long> prefix(size + 1, 1);
        for (int i = 1; i <= size; ++i) {
            prefix[i] = prefix[i - 1] * i;
        }
        vector<long long> result;
        for (auto& q : queries) {
            int l = q[0], r = q[1];
            long long product = prefix[r + 1] / prefix[l];
            result.push_back(product);
        }
        return result;
    }
};