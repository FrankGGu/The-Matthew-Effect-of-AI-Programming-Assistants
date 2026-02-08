#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long smallestNumber(long long num) {
        if (num == 0) return 0;

        string s = to_string(num);
        bool isNegative = false;

        if (s[0] == '-') {
            isNegative = true;
            s.erase(0, 1);
        }

        sort(s.begin(), s.end());

        if (isNegative) {
            reverse(s.begin(), s.end());
            return -stoll(s);
        } else {
            return stoll(s);
        }
    }
};