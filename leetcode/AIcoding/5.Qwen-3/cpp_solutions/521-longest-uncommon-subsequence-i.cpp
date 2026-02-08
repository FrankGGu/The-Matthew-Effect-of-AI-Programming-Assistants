#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int findLUSlength(string a, string b) {
        if (a.length() != b.length()) {
            return max(a.length(), b.length());
        } else {
            return a == b ? -1 : a.length();
        }
    }
};