class Solution {
public:
    bool isPalindrome(const std::string& s, int i, int j) {
        while (i < j) {
            if (s[i] != s[j]) {
                return false;
            }
            i++;
            j--;
        }
        return true;
    }

    bool check(const std::string& a, const std::string& b) {
        int n = a.length();
        int i = 0;
        int j = n - 1;

        while (i < j && a[i] == b[j]) {
            i++;
            j--;
        }

        // At this point, the prefix of 'a' matches the suffix of 'b' up to index i and j.
        // The remaining middle part is from index i to j.
        // We need to check if either a[i...j] is a palindrome or b[i...j] is a palindrome.
        return isPalindrome(a, i, j) || isPalindrome(b, i, j);
    }

    bool checkPalindromeFormation(std::string a, std::string b) {
        return check(a, b) || check(b, a);
    }
};