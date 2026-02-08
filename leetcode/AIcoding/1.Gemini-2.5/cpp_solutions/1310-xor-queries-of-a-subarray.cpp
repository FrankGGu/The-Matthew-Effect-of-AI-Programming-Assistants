class Solution {
public:
    std::vector<int> xorQueries(std::vector<int>& arr, std::vector<std::vector<int>>& queries) {
        int n = arr.size();
        std::vector<int> prefix_xor(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix_xor[i + 1] = prefix_xor[i] ^ arr[i];
        }

        std::vector<int> results;
        for (const auto& query : queries) {
            int left = query[0];
            int right = query[1];
            results.push_back(prefix_xor[right + 1] ^ prefix_xor[left]);
        }

        return results;
    }
};