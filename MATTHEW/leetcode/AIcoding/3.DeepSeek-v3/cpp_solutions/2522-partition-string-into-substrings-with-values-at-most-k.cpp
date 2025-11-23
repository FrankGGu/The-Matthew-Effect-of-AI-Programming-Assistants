class Solution {
public:
    int minimumPartition(string s, int k) {
        long long current = 0;
        int res = 1;
        for (char c : s) {
            int digit = c - '0';
            if (digit > k) return -1;
            current = current * 10 + digit;
            if (current > k) {
                res++;
                current = digit;
            }
        }
        return res;
    }
};