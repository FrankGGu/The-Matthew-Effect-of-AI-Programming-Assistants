class Solution {
public:
    vector<int> xorQueries(vector<int>& arr, vector<vector<int>>& queries) {
        int n = arr.size();
        vector<int> prefix(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            prefix[i] = prefix[i - 1] ^ arr[i - 1];
        }
        vector<int> result;
        for (const auto& query : queries) {
            result.push_back(prefix[query[1] + 1] ^ prefix[query[0]]);
        }
        return result;
    }
};