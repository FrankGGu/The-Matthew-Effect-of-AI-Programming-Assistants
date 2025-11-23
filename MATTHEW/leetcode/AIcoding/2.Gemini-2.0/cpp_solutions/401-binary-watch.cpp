#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> readBinaryWatch(int turnedOn) {
        vector<string> result;
        for (int hour = 0; hour < 12; ++hour) {
            for (int minute = 0; minute < 60; ++minute) {
                int bits = 0;
                int temp_hour = hour;
                int temp_minute = minute;

                while (temp_hour > 0) {
                    bits += (temp_hour & 1);
                    temp_hour >>= 1;
                }

                while (temp_minute > 0) {
                    bits += (temp_minute & 1);
                    temp_minute >>= 1;
                }

                if (bits == turnedOn) {
                    result.push_back(to_string(hour) + ":" + (minute < 10 ? "0" : "") + to_string(minute));
                }
            }
        }
        return result;
    }
};