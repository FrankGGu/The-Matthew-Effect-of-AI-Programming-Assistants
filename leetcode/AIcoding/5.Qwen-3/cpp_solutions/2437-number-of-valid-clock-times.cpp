#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int countTime(string time) {
        int count = 0;
        string h = time.substr(0, 2);
        string m = time.substr(3, 2);

        for (int hour = 0; hour <= 23; ++hour) {
            for (int minute = 0; minute <= 59; ++minute) {
                string h_str = (hour < 10) ? "0" + to_string(hour) : to_string(hour);
                string m_str = (minute < 10) ? "0" + to_string(minute) : to_string(minute);

                bool valid = true;
                for (int i = 0; i < 2; ++i) {
                    if (h[i] != '?' && h[i] != h_str[i]) {
                        valid = false;
                        break;
                    }
                }
                for (int i = 0; i < 2; ++i) {
                    if (m[i] != '?' && m[i] != m_str[i]) {
                        valid = false;
                        break;
                    }
                }
                if (valid) {
                    ++count;
                }
            }
        }
        return count;
    }
};