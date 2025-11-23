#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> xorQueries(vector<int>& arr, vector<vector<int>>& queries) {
        int n = arr.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] ^ arr[i];
        }
        vector<int> result;
        for (const auto& q : queries) {
            int l = q[0], r = q[1];
            result.push_back(prefix[r + 1] ^ prefix[l]);
        }
        return result;
    }
};