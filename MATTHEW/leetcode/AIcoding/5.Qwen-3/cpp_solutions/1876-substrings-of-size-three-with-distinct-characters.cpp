#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countGoodSubstrings(string s) {
        int count = 0;
        for (int i = 0; i <= s.length() - 3; ++i) {
            string sub = s.substr(i, 3);
            unordered_set<char> chars(sub.begin(), sub.end());
            if (chars.size() == 3) {
                ++count;
            }
        }
        return count;
    }
};