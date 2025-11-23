class Solution {
public:
    int sumOfUnique(vector<int>& nums) {
        unordered_map<int, int> count;
        int sum = 0;

        for (int num : nums) {
            count[num]++;
        }

        for (const auto& pair : count) {
            if (pair.second == 1) {
                sum += pair.first;
            }
        }

        return sum;
    }
};