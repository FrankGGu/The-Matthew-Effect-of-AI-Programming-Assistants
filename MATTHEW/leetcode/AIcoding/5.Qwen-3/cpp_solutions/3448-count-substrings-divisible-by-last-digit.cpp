#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countSubstringsDivisibleByLastDigit(string s) {
        int count = 0;
        int n = s.length();
        for (int i = 0; i < n; ++i) {
            int lastDigit = s[i] - '0';
            if (lastDigit == 0) continue;
            for (int j = i; j < n; ++j) {
                int num = 0;
                for (int k = i; k <= j; ++k) {
                    num = num * 10 + (s[k] - '0');
                }
                if (num % lastDigit == 0) {
                    ++count;
                }
            }
        }
        return count;
    }
};