class Solution {
public:
    vector<int> getDistances(vector<int>& arr) {
        unordered_map<int, vector<int>> indices;
        int n = arr.size();
        vector<int> result(n, 0);

        for (int i = 0; i < n; ++i) {
            indices[arr[i]].push_back(i);
        }

        for (const auto& [num, idxs] : indices) {
            int prefixSum = 0;
            int count = idxs.size();

            for (int i = 0; i < count; ++i) {
                result[idxs[i]] += idxs[i] * i - prefixSum;
                prefixSum += idxs[i];
            }

            prefixSum = 0;
            for (int i = count - 1; i >= 0; --i) {
                result[idxs[i]] += prefixSum - idxs[i] * (count - 1 - i);
                prefixSum += idxs[i];
            }
        }

        return result;
    }
};