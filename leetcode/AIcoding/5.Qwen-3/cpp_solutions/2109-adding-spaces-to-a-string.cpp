#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string addSpaces(string s, vector<int>& spaces) {
        string result;
        int n = s.size();
        int m = spaces.size();
        int j = 0;
        for (int i = 0; i < n; ++i) {
            if (j < m && i == spaces[j]) {
                result += ' ';
                ++j;
            }
            result += s[i];
        }
        return result;
    }
};