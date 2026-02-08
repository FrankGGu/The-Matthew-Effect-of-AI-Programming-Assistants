#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> palindromeBuilder(int n, int k) {
        vector<string> result;
        string prefix = "";
        for (int i = 0; i < n; ++i) {
            prefix += 'a';
        }
        for (int i = 0; i < k; ++i) {
            string s = prefix;
            string suffix = s;
            reverse(suffix.begin(), suffix.end());
            s += suffix;
            result.push_back(s);
            for (int j = n - 1; j >= 0; --j) {
                if (s[j] < 'z') {
                    s[j]++;
                    for (int m = j + 1; m < n; ++m) {
                        s[m] = 'a';
                    }
                    break;
                }
            }
        }
        return result;
    }

    vector<string> palindromes(int n, int k) {
        vector<string> result;
        string first = "";
        for (int i = 0; i < n; ++i) {
            first += 'a';
        }
        result.push_back(first);
        for (int i = 1; i < k; ++i) {
            string current = result.back();
            for (int j = n - 1; j >= 0; --j) {
                if (current[j] < 'z') {
                    current[j]++;
                    for (int m = j + 1; m < n; ++m) {
                        current[m] = 'a';
                    }
                    break;
                }
            }
            string mirror = current;
            reverse(mirror.begin(), mirror.end());
            current += mirror;
            result.push_back(current);
        }
        return result;
    }

    vector<string> palindromeFromNumber(int n, int k) {
        vector<string> result;
        for (int i = 0; i < k; ++i) {
            string s = "";
            for (int j = 0; j < n; ++j) {
                s += 'a' + (i % 26);
            }
            string mirror = s;
            reverse(mirror.begin(), mirror.end());
            s += mirror;
            result.push_back(s);
        }
        return result;
    }

    vector<string> palindromeWithFixedLength(int n, int k) {
        if (n == 1) {
            return palindromeFromNumber(n, k);
        } else {
            return palindromes(n, k);
        }
    }
};