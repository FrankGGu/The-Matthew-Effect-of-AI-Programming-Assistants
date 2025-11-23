class Solution {
public:
    vector<int> numberOfPairs(vector<int>& nums) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }
        int pairs = 0, leftovers = 0;
        for (auto& [num, cnt] : count) {
            pairs += cnt / 2;
            leftovers += cnt % 2;
        }
        return {pairs, leftovers};
    }
};