class Solution {
public:
    int gcd(int a, int b) {
        if (b == 0)
            return a;
        return gcd(b, a % b);
    }
    bool isGoodArray(vector<int>& nums) {
        int result = 0;
        for (int num : nums) {
            result = gcd(result, num);
        }
        return result == 1;
    }
};