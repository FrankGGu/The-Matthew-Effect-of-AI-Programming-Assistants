#include <vector>

using namespace std;

class Solution {
public:
    vector<int> xorQueries(vector<int>& arr, vector<vector<int>>& queries) {
        int n = arr.size();
        vector<int> prefix_xor(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix_xor[i + 1] = prefix_xor[i] ^ arr[i];
        }

        vector<int> result;
        for (auto& query : queries) {
            int left = query[0];
            int right = query[1];
            result.push_back(prefix_xor[right + 1] ^ prefix_xor[left]);
        }

        return result;
    }
};