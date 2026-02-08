#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    bool isFascinating(string n) {
        if (n.length() != 3 && n.length() != 2) return false;
        string s = n + to_string(stoi(n) * 2) + to_string(stoi(n) * 3);
        if (s.length() != 9) return false;
        vector<bool> seen(10, false);
        for (char c : s) {
            int num = c - '0';
            if (num == 0 || seen[num]) return false;
            seen[num] = true;
        }
        return true;
    }
};