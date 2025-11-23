#include <string>
#include <algorithm>
#include <cmath>

class Solution {
public:
    bool isPrime(int num) {
        if (num < 2) return false;
        if (num == 2 || num == 3) return true;
        if (num % 2 == 0 || num % 3 == 0) return false;
        for (int i = 5; i * i <= num; i += 6) {
            if (num % i == 0 || num % (i + 2) == 0) {
                return false;
            }
        }
        return true;
    }

    int primePalindrome(int N) {
        if (N == 1) return 2;
        if (N == 2) return 2;
        if (N == 3) return 3;
        if (N <= 5) return 5;
        if (N <= 7) return 7;
        if (N <= 11) return 11;

        for (int i = 1; i < 20000; ++i) {
            std::string s = std::to_string(i);
            std::string rev_s = s;
            std::reverse(rev_s.begin(), rev_s.end());

            std::string p_str = s + rev_s.substr(1);
            int p = std::stoi(p_str);

            if (p >= N && isPrime(p)) {
                return p;
            }
        }
        return -1; 
    }
};