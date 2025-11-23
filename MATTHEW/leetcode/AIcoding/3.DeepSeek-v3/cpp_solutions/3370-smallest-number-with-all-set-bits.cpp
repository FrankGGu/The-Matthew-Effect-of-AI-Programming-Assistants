class Solution {
public:
    int smallestNumber(int num) {
        if (num == 0) return 0;
        int count = __builtin_popcount(num);
        int res = (1 << count) - 1;
        return res;
    }
};