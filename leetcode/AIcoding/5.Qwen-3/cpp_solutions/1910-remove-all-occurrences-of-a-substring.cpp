#include <iostream>
#include <string>

using namespace std;

class Solution {
public:
    string removeOccurrences(string s, string part) {
        int pos;
        while ((pos = s.find(part)) != string::npos) {
            s.erase(pos, part.length());
        }
        return s;
    }
};