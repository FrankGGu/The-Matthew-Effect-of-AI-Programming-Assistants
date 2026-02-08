#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool isAdditiveNumber(string num) {
        int n = num.length();
        for (int i = 1; i < n - 1; ++i) {
            if (num[0] == '0' && i > 1) break;
            long first = stol(num.substr(0, i));
            for (int j = i + 1; j < n; ++j) {
                if (num[i] == '0' && j > i + 1) break;
                long second = stol(num.substr(i, j - i));
                long next = first + second;
                int k = j;
                bool valid = true;
                while (k < n) {
                    string nextStr = to_string(next);
                    if (k + nextStr.length() > n || num.substr(k, nextStr.length()) != nextStr) {
                        valid = false;
                        break;
                    }
                    k += nextStr.length();
                    first = second;
                    second = next;
                    next = first + second;
                }
                if (valid) return true;
            }
        }
        return false;
    }
};