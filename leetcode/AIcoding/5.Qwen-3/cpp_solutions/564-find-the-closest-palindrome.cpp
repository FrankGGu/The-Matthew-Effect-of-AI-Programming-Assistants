#include <iostream>
#include <vector>
#include <string>
#include <cmath>

using namespace std;

class Solution {
public:
    string nearestPalindrome(string n) {
        int len = n.length();
        if (len == 1) return to_string(stoi(n) - 1);

        string prefix = n.substr(0, (len + 1) / 2);
        long num = stol(prefix);
        vector<long> candidates = {num - 1, num, num + 1};

        string result;
        long minDiff = LONG_MAX;

        for (long candidate : candidates) {
            string left = to_string(candidate);
            string right = left;
            if (len % 2 == 1) right.pop_back();
            string temp = left + right;

            if (temp.length() != len) continue;

            long current = stol(temp);
            long diff = abs(current - stol(n));

            if (diff < minDiff || (diff == minDiff && current < stol(result))) {
                minDiff = diff;
                result = temp;
            }
        }

        return result;
    }
};