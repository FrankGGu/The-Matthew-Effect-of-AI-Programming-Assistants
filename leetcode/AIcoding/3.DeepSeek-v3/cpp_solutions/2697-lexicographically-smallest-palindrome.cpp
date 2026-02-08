class Solution {
public:
    string makeSmallestPalindrome(string s) {
        int left = 0, right = s.size() - 1;
        while (left < right) {
            if (s[left] != s[right]) {
                char minChar = min(s[left], s[right]);
                s[left] = minChar;
                s[right] = minChar;
            }
            left++;
            right--;
        }
        return s;
    }
};