class Solution {
public:
    int subarraysDivByK(vector<int>& nums, int k) {
        unordered_map<int, int> count;
        count[0] = 1;
        int sum = 0, result = 0;

        for (int num : nums) {
            sum += num;
            int remainder = (sum % k + k) % k;
            result += count[remainder];
            count[remainder]++;
        }

        return result;
    }
};