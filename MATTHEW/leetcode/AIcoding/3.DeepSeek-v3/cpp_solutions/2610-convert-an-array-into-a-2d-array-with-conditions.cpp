class Solution {
public:
    vector<vector<int>> findMatrix(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        vector<vector<int>> result;
        while (!freq.empty()) {
            vector<int> row;
            for (auto it = freq.begin(); it != freq.end(); ) {
                row.push_back(it->first);
                if (--it->second == 0) {
                    it = freq.erase(it);
                } else {
                    ++it;
                }
            }
            result.push_back(row);
        }
        return result;
    }
};