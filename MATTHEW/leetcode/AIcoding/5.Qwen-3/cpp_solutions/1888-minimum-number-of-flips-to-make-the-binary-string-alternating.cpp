#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minFlipsAlternating(string s) {
        int n = s.size();
        int flip0 = 0, flip1 = 0;

        for (int i = 0; i < n; ++i) {
            if (i % 2 == 0) {
                if (s[i] != '0') flip0++;
                if (s[i] != '1') flip1++;
            } else {
                if (s[i] != '1') flip0++;
                if (s[i] != '0') flip1++;
            }
        }

        return min(flip0, flip1);
    }
};