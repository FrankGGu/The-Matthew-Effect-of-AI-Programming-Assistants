#include <string>
#include <vector>

class Solution {
public:
    bool canBeValid(std::string s, std::string locked) {
        int n = s.length();
        if (n % 2 != 0) {
            return false;
        }

        int balance = 0;
        for (int i = 0; i < n; ++i) {
            if (locked[i] == '0' || s[i] == '(') {
                balance++;
            } else {
                balance--;
            }
            if (balance < 0) {
                return false;
            }
        }

        balance = 0;
        for (int i = n - 1; i >= 0; --i) {
            if (locked[i] == '0' || s[i] == ')') {
                balance++;
            } else {
                balance--;
            }
            if (balance < 0) {
                return false;
            }
        }

        return true;
    }
};