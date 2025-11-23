class Solution {
public:
    vector<int> intersection(vector<vector<int>>& nums) {
        unordered_map<int, int> freq;
        for (auto& arr : nums) {
            for (int num : arr) {
                freq[num]++;
            }
        }
        vector<int> res;
        int n = nums.size();
        for (auto& [num, count] : freq) {
            if (count == n) {
                res.push_back(num);
            }
        }
        sort(res.begin(), res.end());
        return res;
    }
};