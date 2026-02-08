class Solution {
public:
    bool checkPalindrome(string s) {
        int left = 0, right = s.length() - 1;
        while (left < right) {
            if (s[left] != s[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }

    bool check(string a, string b) {
        int left = 0, right = a.length() - 1;
        while (left < right && a[left] == b[right]) {
            left++;
            right--;
        }
        string s = a.substr(left, right - left + 1);
        string t = b.substr(left, right - left + 1);
        return checkPalindrome(s) || checkPalindrome(t);
    }

    bool checkPalindromeFormation(string a, string b) {
        return check(a, b) || check(b, a);
    }
};