#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minimumValueAfterOperations(string s) {
        int n = s.length();
        int result = 0;
        for (int i = 0; i < n; ++i) {
            if (s[i] == 'A') {
                if (i + 1 < n && s[i + 1] == 'B') {
                    result += 1;
                    ++i;
                } else {
                    result += 2;
                }
            } else {
                result += 1;
            }
        }
        return result;
    }
};