#include <algorithm>

using namespace std;

class Solution {
public:
    int minCostSetTime(int startAt, int moveCost, int pushCost, int targetSeconds) {
        int minCost = INT_MAX;

        for (int minutes = 0; minutes <= 99; ++minutes) {
            int seconds = targetSeconds - minutes * 60;
            if (seconds >= 0 && seconds <= 99) {
                string timeStr = "";
                if (minutes > 0) {
                    timeStr += to_string(minutes);
                } else {
                    timeStr += "0";
                }
                if (seconds < 10) {
                    timeStr += "0";
                }
                timeStr += to_string(seconds);

                int cost = 0;
                int currentDigit = startAt;
                bool firstDigit = true;
                for (char c : timeStr) {
                    if (firstDigit && c == '0' && timeStr.length() > 1) {
                        continue;
                    }
                    firstDigit = false;
                    int digit = c - '0';
                    if (digit != currentDigit) {
                        cost += moveCost;
                        currentDigit = digit;
                    }
                    cost += pushCost;
                }

                minCost = min(minCost, cost);
            }
        }

        int minutes = targetSeconds / 60;
        int seconds = targetSeconds % 60;

        if (minutes <= 99) {
            string timeStr = "";
            if (minutes > 0) {
                timeStr += to_string(minutes);
            } else {
                timeStr += "0";
            }
            if (seconds < 10) {
                timeStr += "0";
            }
            timeStr += to_string(seconds);

            int cost = 0;
            int currentDigit = startAt;
            bool firstDigit = true;
            for (char c : timeStr) {
                if (firstDigit && c == '0' && timeStr.length() > 1) {
                    continue;
                }
                firstDigit = false;
                int digit = c - '0';
                if (digit != currentDigit) {
                    cost += moveCost;
                    currentDigit = digit;
                }
                cost += pushCost;
            }

            minCost = min(minCost, cost);
        }

        return minCost;
    }
};