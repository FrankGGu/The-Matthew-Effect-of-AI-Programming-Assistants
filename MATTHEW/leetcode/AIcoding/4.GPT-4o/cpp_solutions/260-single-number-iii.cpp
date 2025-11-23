class Solution {
public:
    vector<int> singleNumber(vector<int>& nums) {
        int xorResult = 0;
        for (int num : nums) {
            xorResult ^= num;
        }

        int rightmostSetBit = xorResult & (-xorResult);
        vector<int> result(2, 0);

        for (int num : nums) {
            if (num & rightmostSetBit) {
                result[0] ^= num;
            } else {
                result[1] ^= num;
            }
        }

        return result;
    }
};