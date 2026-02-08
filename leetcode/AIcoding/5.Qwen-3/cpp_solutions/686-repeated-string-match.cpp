#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int repeatedStringMatch(string a, string b) {
        string s = a;
        int count = 1;
        while (s.find(b) == string::npos) {
            s += a;
            count++;
            if (s.length() > b.length() + a.length()) {
                return -1;
            }
        }
        return count;
    }
};