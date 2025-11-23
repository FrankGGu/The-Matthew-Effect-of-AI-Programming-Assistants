#include <string>
#include <algorithm>
#include <limits> // For std::numeric_limits

class Solution {
public:
    long long calculateCost(std::string s, int startAt, int moveCost, int pushCost) {
        // Remove leading zeros from the string representation.
        // For example, "0070" becomes "70", "0110" becomes "110", "0000" becomes "0".
        int first_digit_idx = 0;
        while (first_digit_idx < s.length() - 1 && s[first_digit_idx] == '0') {
            first_digit_idx++;
        }
        s = s.substr(first_digit_idx);

        long long current_cost = 0;
        int current_finger_pos = startAt;

        for (char c : s) {
            int digit = c - '0';
            if (digit != current_finger_pos) {
                current_cost += moveCost;
                current_finger_pos = digit;
            }
            current_cost += pushCost;
        }
        return current_cost;
    }

    int minCostSettingTime(int targetSeconds, int startAt, int moveCost, int pushCost) {
        long long min_total_cost = std::numeric_limits<long long>::max();

        // Option 1: Represent targetSeconds directly as MM:SS
        // minutes = targetSeconds / 60
        // seconds = targetSeconds % 60
        int m1 = targetSeconds / 60;
        int s1 = targetSeconds % 60;

        // The minutes part (m1) must be a 2-digit number (00-99).
        if (m1 <= 99) {
            std::string s_m1 = std::to_string(m1);
            if (s_m1.length() == 1) {
                s_m1 = "0" + s_m1;
            }
            std::string s_s1 = std::to_string(s1);
            if (s_s1.length() == 1) {
                s_s1 = "0" + s_s1;
            }
            std::string str1 = s_m1 + s_s1;
            min_total_cost = std::min(min_total_cost, calculateCost(str1, startAt, moveCost, pushCost));
        }

        // Option 2: Represent targetSeconds as (M-1):(S+60)
        // This means "borrowing" 1 minute and adding 60 seconds.
        // This is only possible if:
        // 1. targetSeconds has at least 1 full minute (to borrow from).
        // 2. The new minutes part (m2) is non-negative and a 2-digit number (00-99).
        // 3. The new seconds part (s2) does not exceed 99.
        if (targetSeconds / 60 >= 1) { // Ensures there's at least 1 minute to borrow
            int m2 = (targetSeconds / 60) - 1;
            int s2 = (targetSeconds % 60) + 60;

            if (m2 <= 99 && s2 <= 99) { // m2 >= 0 is covered by the outer condition
                std::string s_m2 = std::to_string(m2);
                if (s_m2.length() == 1) {
                    s_m2 = "0" + s_m2;
                }
                std::string s_s2 = std::to_string(s2);
                if (s_s2.length() == 1) {
                    s_s2 = "0" + s_s2;
                }
                std::string str2 = s_m2 + s_s2;
                min_total_cost = std::min(min_total_cost, calculateCost(str2, startAt, moveCost, pushCost));
            }
        }

        return static_cast<int>(min_total_cost);
    }
};