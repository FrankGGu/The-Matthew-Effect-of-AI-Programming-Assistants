#include <string>
#include <algorithm>

class Solution {
public:
    std::string strWithout3a3b(int A, int B) {
        std::string res = "";
        while (A > 0 || B > 0) {
            bool can_add_a = false;
            bool can_add_b = false;

            if (A > 0) {
                if (res.size() < 2 || !(res.back() == 'a' && res[res.size() - 2] == 'a')) {
                    can_add_a = true;
                }
            }

            if (B > 0) {
                if (res.size() < 2 || !(res.back() == 'b' && res[res.size() - 2] == 'b')) {
                    can_add_b = true;
                }
            }

            if (can_add_a && can_add_b) {
                if (A >= B) {
                    res += 'a';
                    A--;
                } else {
                    res += 'b';
                    B--;
                }
            } else if (can_add_a) {
                res += 'a';
                A--;
            } else if (can_add_b) {
                res += 'b';
                B--;
            } else {
                // This branch should ideally not be reached if a solution of length A+B always exists.
                // It implies A>0 or B>0, but neither character can be added without violating the rule.
                // This might happen for inputs where no such string can be formed (e.g., A=3, B=0).
                // However, for valid inputs where a solution is guaranteed, this path is avoided by the greedy choices.
                break; 
            }
        }
        return res;
    }
};