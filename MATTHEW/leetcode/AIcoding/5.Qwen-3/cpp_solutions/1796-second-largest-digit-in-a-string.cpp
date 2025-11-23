#include <iostream>
#include <vector>
#include <string>
#include <set>

using namespace std;

class Solution {
public:
    int secondLargest(string s) {
        set<char> digits;
        for (char c : s) {
            if (isdigit(c)) {
                digits.insert(c);
            }
        }
        if (digits.size() < 2) {
            return -1;
        }
        auto it = digits.rbegin();
        ++it;
        return *it - '0';
    }
};