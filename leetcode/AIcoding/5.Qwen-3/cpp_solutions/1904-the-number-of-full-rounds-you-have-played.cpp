#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <cmath>

using namespace std;

class Solution {
public:
    int number_of_full_rounds(string startTime, string endTime) {
        auto toMinutes = [](const string& time) {
            int hours = 0, minutes = 0;
            sscanf(time.c_str(), "%d:%d", &hours, &minutes);
            return hours * 60 + minutes;
        };

        int start = toMinutes(startTime);
        int end = toMinutes(endTime);

        if (start > end) {
            end += 24 * 60;
        }

        int fullRounds = (end - start) / 60;
        return fullRounds;
    }
};