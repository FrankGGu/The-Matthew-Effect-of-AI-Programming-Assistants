#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countBinarySubstrings(string s) {
        int prev = 0, curr = 1, count = 0;
        for (int i = 1; i < s.length(); i++) {
            if (s[i] == s[i - 1]) {
                curr++;
            } else {
                count += min(prev, curr);
                prev = curr;
                curr = 1;
            }
        }
        count += min(prev, curr);
        return count;
    }
};