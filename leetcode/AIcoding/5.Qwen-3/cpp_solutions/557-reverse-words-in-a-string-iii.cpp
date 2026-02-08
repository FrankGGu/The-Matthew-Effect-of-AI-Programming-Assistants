#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string reverseWords(string s) {
        int n = s.length();
        int start = 0;
        for (int i = 0; i <= n; ++i) {
            if (i == n || s[i] == ' ') {
                int end = i - 1;
                while (start < end) {
                    swap(s[start], s[end]);
                    ++start;
                    --end;
                }
                start = i + 1;
            }
        }
        return s;
    }
};