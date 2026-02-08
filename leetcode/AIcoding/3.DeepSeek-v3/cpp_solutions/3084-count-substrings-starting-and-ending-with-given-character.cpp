class Solution {
public:
    long long countSubstrings(string s, char c) {
        long long count = 0;
        long long total = 0;
        for (char ch : s) {
            if (ch == c) {
                count++;
                total += count;
            }
        }
        return total;
    }
};