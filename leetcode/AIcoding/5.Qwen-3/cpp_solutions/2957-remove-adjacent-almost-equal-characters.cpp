#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int removeAlmostEqualCharacters(string s) {
        int n = s.size();
        int count = 0;
        for (int i = 1; i < n; ) {
            if (abs(s[i] - s[i - 1]) <= 1) {
                count++;
                i += 2;
            } else {
                i++;
            }
        }
        return n - count;
    }
};