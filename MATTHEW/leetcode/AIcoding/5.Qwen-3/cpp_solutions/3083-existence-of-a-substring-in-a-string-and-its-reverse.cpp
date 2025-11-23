#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool isSubstringInReverse(const string& s, const string& sub) {
        string reversed = s;
        reverse(reversed.begin(), reversed.end());
        return reversed.find(sub) != string::npos;
    }
};