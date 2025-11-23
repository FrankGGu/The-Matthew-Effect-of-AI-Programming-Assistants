class Solution {
public:
    int findShortestSubArray(vector<int>& nums) {
        unordered_map<int, vector<int>> indices;
        for (int i = 0; i < nums.size(); ++i) {
            indices[nums[i]].push_back(i);
        }
        int max_freq = 0;
        for (const auto& pair : indices) {
            max_freq = max(max_freq, (int)pair.second.size());
        }
        int min_len = nums.size();
        for (const auto& pair : indices) {
            if (pair.second.size() == max_freq) {
                min_len = min(min_len, pair.second.back() - pair.second.front() + 1);
            }
        }
        return min_len;
    }
};