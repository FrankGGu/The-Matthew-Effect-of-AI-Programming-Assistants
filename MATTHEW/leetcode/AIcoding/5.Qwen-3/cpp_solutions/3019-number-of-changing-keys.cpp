#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countChanges(string s) {
        int count = 0;
        for (int i = 1; i < s.length(); ++i) {
            if (s[i] != s[i - 1]) {
                ++count;
            }
        }
        return count;
    }
};