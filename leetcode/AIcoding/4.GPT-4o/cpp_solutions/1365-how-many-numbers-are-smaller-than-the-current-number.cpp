class Solution {
public:
    vector<int> smallerNumbersThanCurrent(vector<int>& nums) {
        vector<int> count(101, 0);
        for (int num : nums) {
            count[num]++;
        }
        for (int i = 1; i < 101; i++) {
            count[i] += count[i - 1];
        }
        vector<int> result;
        for (int num : nums) {
            result.push_back(num == 0 ? 0 : count[num - 1]);
        }
        return result;
    }
};