class Solution {
public:
    int countPairs(vector<int>& nums) {
        int n = nums.size();
        unordered_map<int, int> count;
        long long result = 0;

        for (int num : nums) {
            result += count[num];
            count[num]++;
        }

        return result;
    }
};