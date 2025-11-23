class Solution {
public:
    bool xorAllSegs(vector<int>& nums1, vector<int>& nums2) {
        int xor1 = 0, xor2 = 0;
        for (int num : nums1) xor1 ^= num;
        for (int num : nums2) xor2 ^= num;

        return (xor1 == 0) || (xor2 == 0) || (xor1 ^ xor2 == 0);
    }
};