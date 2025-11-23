#include <iostream>
#include <vector>
#include <string>
#include <stack>

using namespace std;

class Solution {
public:
    string decodeAtIndex(string s, int k) {
        long long size = 0;
        for (char c : s) {
            if (isdigit(c)) {
                size *= (c - '0');
            } else {
                size++;
            }
        }

        for (int i = s.length() - 1; i >= 0; --i) {
            char c = s[i];
            if (isdigit(c)) {
                size /= (c - '0');
            } else {
                if (size == k) {
                    return string(1, c);
                }
                size--;
            }
        }

        return "";
    }
};