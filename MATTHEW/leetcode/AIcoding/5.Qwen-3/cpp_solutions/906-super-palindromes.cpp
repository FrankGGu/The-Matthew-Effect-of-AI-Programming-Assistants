#include <iostream>
#include <vector>
#include <cmath>
#include <string>

using namespace std;

class Solution {
public:
    long long toLong(const string& s) {
        long long res = 0;
        for (char c : s) {
            res = res * 10 + (c - '0');
        }
        return res;
    }

    bool isPalindrome(long long n) {
        string s = to_string(n);
        int left = 0, right = s.length() - 1;
        while (left < right) {
            if (s[left] != s[right]) return false;
            left++;
            right--;
        }
        return true;
    }

    vector<long long> generatePalindromes(int maxLen) {
        vector<long long> result;
        for (int len = 1; len <= maxLen; len++) {
            for (int start = 1; start <= 9; start++) {
                string s(1, start + '0');
                if (len == 1) {
                    result.push_back(stoll(s));
                    continue;
                }
                for (int i = 0; i < len / 2 - 1; i++) {
                    s += '0';
                }
                for (int mid = 0; mid <= 9; mid++) {
                    string temp = s;
                    if (len % 2 == 1) {
                        temp += mid + '0';
                    }
                    for (int j = len / 2 - 1; j >= 0; j--) {
                        temp += temp[j];
                    }
                    result.push_back(stoll(temp));
                }
            }
        }
        return result;
    }

    int superpalindromesInRange(long long L, long long R) {
        vector<long long> palindromes = generatePalindromes(5);
        int count = 0;
        for (long long p : palindromes) {
            long long square = p * p;
            if (square > R) break;
            if (square >= L && isPalindrome(square)) {
                count++;
            }
        }
        return count;
    }

    int numDupDigitsAtMostN(int n) {
        vector<int> digits;
        int m = n;
        while (m > 0) {
            digits.push_back(m % 10);
            m /= 10;
        }
        reverse(digits.begin(), digits.end());

        int res = 0;
        for (int i = 1; i <= 9; i++) {
            if (i <= digits[0]) {
                res++;
            } else {
                break;
            }
        }

        for (int i = 1; i < digits.size(); i++) {
            for (int j = 0; j <= 9; j++) {
                if (j == 0 && i == 1) continue;
                if (j < digits[i]) {
                    res += 9 * pow(9, i - 1);
                } else if (j == digits[i]) {
                    int cnt = 0;
                    for (int k = 0; k < i; k++) {
                        if (digits[k] == j) cnt++;
                    }
                    if (cnt == 0) {
                        res += 9 * pow(9, i - 1);
                    }
                } else {
                    break;
                }
            }
        }

        return res;
    }

    int superpalindromesInRange(long long L, long long R) {
        vector<long long> palindromes = generatePalindromes(5);
        int count = 0;
        for (long long p : palindromes) {
            long long square = p * p;
            if (square > R) break;
            if (square >= L && isPalindrome(square)) {
                count++;
            }
        }
        return count;
    }

    int superpalindromesInRange(string L, string R) {
        long long l = stoll(L);
        long long r = stoll(R);
        return superpalindromesInRange(l, r);
    }
};