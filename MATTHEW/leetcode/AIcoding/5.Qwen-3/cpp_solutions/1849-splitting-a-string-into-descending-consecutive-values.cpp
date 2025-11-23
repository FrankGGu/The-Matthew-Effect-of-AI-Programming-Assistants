#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool splitString(const string& s) {
        int n = s.length();
        for (int i = 0; i < n - 1; ++i) {
            long long first = stoll(s.substr(0, i + 1));
            long long prev = first;
            int j = i + 1;
            bool valid = true;
            while (j < n) {
                long long curr = stoll(s.substr(j));
                if (curr != prev - 1) {
                    valid = false;
                    break;
                }
                prev = curr;
                j += to_string(curr).length();
            }
            if (valid) return true;
        }
        return false;
    }
};