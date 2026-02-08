class Solution {
public:
    int primePalindrome(int N) {
        if (N <= 2) return 2;
        for (int i = max(3, (N + 1) | 1); ; i += 2) {
            if (isPalindrome(i) && isPrime(i)) {
                return i;
            }
        }
    }

private:
    bool isPalindrome(int n) {
        string s = to_string(n);
        return s == string(s.rbegin(), s.rend());
    }

    bool isPrime(int n) {
        if (n < 2) return false;
        for (int i = 2; i * i <= n; ++i) {
            if (n % i == 0) return false;
        }
        return true;
    }
};