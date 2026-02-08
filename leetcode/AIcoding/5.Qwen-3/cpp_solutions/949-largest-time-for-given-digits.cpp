#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string largestTimeFromDigits(vector<int>& a) {
        int max_time = -1;
        for (int i = 0; i < 4; ++i) {
            for (int j = 0; j < 4; ++j) {
                if (j == i) continue;
                for (int k = 0; k < 4; ++k) {
                    if (k == i || k == j) continue;
                    int l = 6 - i - j - k;
                    int hour = a[i] * 10 + a[j];
                    int minute = a[k] * 10 + a[l];
                    if (hour < 24 && minute < 60) {
                        max_time = max(max_time, hour * 60 + minute);
                    }
                }
            }
        }
        if (max_time == -1) return "";
        int hour = max_time / 60;
        int minute = max_time % 60;
        return (hour < 10 ? "0" : "") + to_string(hour) + ":" + (minute < 10 ? "0" : "") + to_string(minute);
    }
};