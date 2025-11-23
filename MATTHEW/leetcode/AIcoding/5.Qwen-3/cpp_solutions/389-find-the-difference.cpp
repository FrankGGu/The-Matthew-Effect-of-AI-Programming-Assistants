#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    char findTheDifference(string s, string t) {
        vector<int> count(26, 0);
        for (char c : s) {
            count[c - 'a']++;
        }
        for (char c : t) {
            if (count[c - 'a'] == 0) {
                return c;
            }
            count[c - 'a']--;
        }
        return ' ';
    }
};