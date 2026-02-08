#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestPalindrome(string s) {
        unordered_map<char, int> count;
        for (char c : s) {
            count[c]++;
        }

        int maxLen = 0;
        bool hasOdd = false;

        for (auto& [c, cnt] : count) {
            if (cnt % 2 == 0) {
                maxLen += cnt;
            } else {
                maxLen += cnt - 1;
                hasOdd = true;
            }
        }

        if (hasOdd) {
            maxLen += 1;
        }

        return maxLen;
    }
};