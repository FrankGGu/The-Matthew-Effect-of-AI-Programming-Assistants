class Solution {
public:
    bool isPalindrome(long long num) {
        long long original = num;
        long long reversed = 0;
        while (num > 0) {
            reversed = reversed * 10 + num % 10;
            num /= 10;
        }
        return original == reversed;
    }

    int superpalindromesInRange(string left, string right) {
        long long L = stoll(left);
        long long R = stoll(right);
        int count = 0;

        for (int k = 1; k < 100000; ++k) {
            string s = to_string(k);
            string rev_s(s.rbegin(), s.rend());
            long long pal = stoll(s + rev_s);
            long long square = pal * pal;
            if (square > R) break;
            if (square >= L && isPalindrome(square)) {
                ++count;
            }
        }

        for (int k = 1; k < 100000; ++k) {
            string s = to_string(k);
            string rev_s(s.rbegin(), s.rend());
            long long pal = stoll(s + rev_s.substr(1));
            long long square = pal * pal;
            if (square > R) break;
            if (square >= L && isPalindrome(square)) {
                ++count;
            }
        }

        return count;
    }
};