#include <iostream>
#include <string>

using namespace std;

class Solution {
public:
    int numSteps(string s) {
        int steps = 0;
        int n = s.length();
        for (int i = n - 1; i > 0; --i) {
            if (s[i] == '1') {
                steps += 2;
                s[i - 1] = (s[i - 1] == '0') ? '1' : '0';
            } else {
                steps++;
            }
        }
        return s[0] == '1' ? steps : steps - 1;
    }
};