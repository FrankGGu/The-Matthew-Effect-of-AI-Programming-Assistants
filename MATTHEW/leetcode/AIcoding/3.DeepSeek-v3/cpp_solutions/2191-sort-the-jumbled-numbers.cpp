class Solution {
public:
    vector<int> sortJumbled(vector<int>& mapping, vector<int>& nums) {
        vector<pair<int, int>> mappedNums;
        for (int i = 0; i < nums.size(); ++i) {
            int num = nums[i];
            int mappedNum = 0;
            if (num == 0) {
                mappedNum = mapping[0];
            } else {
                int power = 1;
                while (num > 0) {
                    int digit = num % 10;
                    mappedNum += mapping[digit] * power;
                    power *= 10;
                    num /= 10;
                }
            }
            mappedNums.emplace_back(mappedNum, i);
        }
        sort(mappedNums.begin(), mappedNums.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            if (a.first != b.first) {
                return a.first < b.first;
            } else {
                return a.second < b.second;
            }
        });
        vector<int> result;
        for (const auto& p : mappedNums) {
            result.push_back(nums[p.second]);
        }
        return result;
    }
};