class Solution {
public:
    int primePalindrome(int N) {
        if (N >= 8 && N <= 11) return 11;
        for (int x = 1; x < 100000; ++x) {
            string s = to_string(x), r(s.rbegin(), s.rend());
            int y = stoi(s + r.substr(1));
            if (y >= N && isPrime(y)) return y;
        }
        return -1;
    }

    bool isPrime(int num) {
        if (num < 2) return false;
        for (int i = 2; i * i <= num; ++i) {
            if (num % i == 0) return false;
        }
        return true;
    }
};