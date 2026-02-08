class Solution {
public:
    vector<long long> getDistances(vector<int>& arr) {
        unordered_map<int, vector<int>> mp;
        for (int i = 0; i < arr.size(); ++i) {
            mp[arr[i]].push_back(i);
        }

        vector<long long> res(arr.size(), 0);
        for (auto& [num, indices] : mp) {
            int n = indices.size();
            vector<long long> prefix(n, 0);
            vector<long long> suffix(n, 0);

            for (int i = 1; i < n; ++i) {
                prefix[i] = prefix[i-1] + (long long)i * (indices[i] - indices[i-1]);
            }

            for (int i = n-2; i >= 0; --i) {
                suffix[i] = suffix[i+1] + (long long)(n - 1 - i) * (indices[i+1] - indices[i]);
            }

            for (int i = 0; i < n; ++i) {
                res[indices[i]] = prefix[i] + suffix[i];
            }
        }
        return res;
    }
};