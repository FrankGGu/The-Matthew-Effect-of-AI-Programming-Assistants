class Solution {
public:
    long long zeroFilledSubarray(vector<int>& nums) {
        long long count = 0, length = 0;
        for (int num : nums) {
            if (num == 0) {
                length++;
                count += length;
            } else {
                length = 0;
            }
        }
        return count;
    }
};