class Solution {
public:
    vector<int> findLonely(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }
        vector<int> result;
        for (int num : nums) {
            if (freq[num] == 1 && freq.find(num - 1) == freq.end() && freq.find(num + 1) == freq.end()) {
                result.push_back(num);
            }
        }
        return result;
    }
};