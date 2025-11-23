class Solution {
public:
    int superpalindromesInRange(string L, string R) {
        long long left = stoll(L), right = stoll(R), count = 0;
        for (long long i = 1; i * i <= right; ++i) {
            string s = to_string(i);
            string rev = string(s.rbegin(), s.rend());
            string odd_pal = s + rev.substr(1);
            string even_pal = s + rev;
            long long odd_num = stoll(odd_pal);
            long long even_num = stoll(even_pal);
            if (odd_num * odd_num >= left && odd_num * odd_num <= right && isPalindrome(odd_num * odd_num)) {
                count++;
            }
            if (even_num * even_num >= left && even_num * even_num <= right && isPalindrome(even_num * even_num)) {
                count++;
            }
        }
        return count;
    }

    bool isPalindrome(long long num) {
        string s = to_string(num);
        return equal(s.begin(), s.begin() + s.size() / 2, s.rbegin());
    }
};