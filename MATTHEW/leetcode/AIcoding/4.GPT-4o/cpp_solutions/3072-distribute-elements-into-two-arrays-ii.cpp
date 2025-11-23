class Solution {
public:
    vector<vector<int>> distributeArray(vector<int>& nums) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }
        vector<int> first, second;
        for (auto& [num, cnt] : count) {
            int half = cnt / 2;
            first.insert(first.end(), half, num);
            second.insert(second.end(), cnt - half, num);
        }
        return {first, second};
    }
};