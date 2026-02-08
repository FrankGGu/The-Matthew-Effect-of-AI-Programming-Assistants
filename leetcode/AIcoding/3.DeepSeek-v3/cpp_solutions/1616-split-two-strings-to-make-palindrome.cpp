class Solution {
public:
    bool checkPalindromeFormation(string a, string b) {
        return check(a, b) || check(b, a);
    }

private:
    bool check(const string& a, const string& b) {
        int left = 0, right = a.size() - 1;
        while (left < right && a[left] == b[right]) {
            left++;
            right--;
        }
        return isPalindrome(a, left, right) || isPalindrome(b, left, right);
    }

    bool isPalindrome(const string& s, int left, int right) {
        while (left < right) {
            if (s[left] != s[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
};