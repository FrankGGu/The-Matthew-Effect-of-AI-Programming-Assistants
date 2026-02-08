#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countSubstrings(string s, char c) {
        int count = 0;
        for (int i = 0; i < s.length(); ++i) {
            if (s[i] == c) {
                count++;
            }
        }
        return count * (count + 1) / 2;
    }
};