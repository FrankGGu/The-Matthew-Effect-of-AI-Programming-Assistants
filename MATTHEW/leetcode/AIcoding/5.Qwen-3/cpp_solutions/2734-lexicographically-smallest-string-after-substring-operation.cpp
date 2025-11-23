#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string lexSmallestString(string s, string c) {
        int n = s.size();
        for (int i = 0; i < n; ++i) {
            if (s[i] == c[0]) {
                int j = i;
                while (j < n && s[j] == c[0]) {
                    ++j;
                }
                for (int k = i; k < j; ++k) {
                    s[k] = c[1];
                }
                break;
            }
        }
        return s;
    }
};