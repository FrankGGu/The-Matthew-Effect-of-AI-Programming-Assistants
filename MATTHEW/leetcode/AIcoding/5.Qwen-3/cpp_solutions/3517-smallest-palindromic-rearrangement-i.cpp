#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    string primePalindrome(int n) {
        if (n <= 2) return "2";
        if (n <= 3) return "3";
        if (n <= 5) return "5";
        if (n <= 7) return "7";

        for (int i = 1; i <= 100000; ++i) {
            string s = to_string(i);
            string rev = s;
            reverse(rev.begin(), rev.end());
            string candidate = s + rev;
            int num = stoi(candidate);
            if (num >= n && isPrime(num)) {
                return candidate;
            }
            candidate = s + rev.substr(1);
            num = stoi(candidate);
            if (num >= n && isPrime(num)) {
                return candidate;
            }
        }
        return "";
    }

private:
    bool isPrime(int x) {
        if (x < 2) return false;
        if (x == 2) return true;
        if (x % 2 == 0) return false;
        for (int i = 3; i * i <= x; i += 2) {
            if (x % i == 0) return false;
        }
        return true;
    }
};