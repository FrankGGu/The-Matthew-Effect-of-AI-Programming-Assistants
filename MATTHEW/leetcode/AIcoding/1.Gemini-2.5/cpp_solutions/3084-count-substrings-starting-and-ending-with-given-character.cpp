class Solution {
public:
    long long countSubstrings(std::string s, char c) {
        long long count = 0;
        long long ans = 0;
        for (char ch : s) {
            if (ch == c) {
                count++;
                ans += count;
            }
        }
        return ans;
    }
};