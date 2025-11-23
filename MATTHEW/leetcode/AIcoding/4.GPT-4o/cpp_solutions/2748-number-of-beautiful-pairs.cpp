class Solution {
public:
    int countBeautifulPairs(vector<int>& nums) {
        int count = 0;
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }
        for (auto& [num, f] : freq) {
            count += f * (f - 1) / 2;
        }
        return count;
    }
};