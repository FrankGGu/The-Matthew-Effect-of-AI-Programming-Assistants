class Solution {
public:
    vector<int> findKey(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }
        vector<int> result;
        for (auto& [num, count] : freq) {
            if (count == 1) {
                result.push_back(num);
            }
        }
        return result;
    }
};