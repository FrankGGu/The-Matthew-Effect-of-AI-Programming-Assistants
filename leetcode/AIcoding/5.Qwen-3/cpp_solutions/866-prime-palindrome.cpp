#include <iostream>
#include <vector>
#include <cmath>

class Solution {
public:
    int primePalindrome(int n) {
        if (n <= 2) return 2;
        if (n <= 3) return 3;
        if (n <= 5) return 5;
        if (n <= 7) return 7;

        for (int i = 11; ; i += 2) {
            if (isPrime(i) && isPalindrome(i)) {
                return i;
            }
        }
    }

private:
    bool isPalindrome(int x) {
        std::string s = std::to_string(x);
        int left = 0, right = s.size() - 1;
        while (left < right) {
            if (s[left] != s[right]) return false;
            left++;
            right--;
        }
        return true;
    }

    bool isPrime(int x) {
        if (x % 2 == 0) return false;
        int sqrtX = static_cast<int>(std::sqrt(x));
        for (int i = 3; i <= sqrtX; i += 2) {
            if (x % i == 0) return false;
        }
        return true;
    }
};