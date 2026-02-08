#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minimizeStringLength(string s) {
        vector<bool> seen(26, false);
        int count = 0;
        for (char c : s) {
            if (!seen[c - 'a']) {
                seen[c - 'a'] = true;
                count++;
            }
        }
        return count;
    }
};