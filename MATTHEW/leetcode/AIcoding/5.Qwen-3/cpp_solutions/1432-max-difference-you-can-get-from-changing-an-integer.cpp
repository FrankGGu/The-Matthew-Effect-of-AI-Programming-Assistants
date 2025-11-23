#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxDiff(int n) {
        string s = to_string(n);
        int len = s.length();
        int maxVal = 0;
        for (int i = 0; i < len; ++i) {
            if (s[i] != '9') {
                string temp = s;
                for (int j = i; j < len; ++j) {
                    if (temp[j] == s[i]) {
                        temp[j] = '9';
                    }
                }
                maxVal = max(maxVal, stoi(temp));
                break;
            }
        }
        for (int i = 0; i < len; ++i) {
            if (s[i] != '0') {
                string temp = s;
                for (int j = i; j < len; ++j) {
                    if (temp[j] == s[i]) {
                        temp[j] = '0';
                    }
                }
                maxVal = max(maxVal, stoi(temp));
                break;
            }
        }
        return maxVal - n;
    }
};