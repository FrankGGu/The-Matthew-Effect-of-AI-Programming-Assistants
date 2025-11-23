#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string shiftingLetters(string s, vector<int>& shifts) {
        int n = s.size();
        for (int i = n - 1; i >= 0; --i) {
            shifts[i] %= 26;
            s[i] = 'a' + (s[i] - 'a' + shifts[i]) % 26;
            if (i > 0) {
                shifts[i - 1] += shifts[i];
            }
        }
        return s;
    }
};