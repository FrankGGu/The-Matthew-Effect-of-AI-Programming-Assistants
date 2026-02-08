#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int hardestButton(const vector<int>& releaseTimes, const string& keysPressed) {
        int maxTime = 0;
        char hardestChar = 'a';
        int prevTime = 0;

        for (int i = 0; i < releaseTimes.size(); ++i) {
            int duration = releaseTimes[i] - prevTime;
            if (duration > maxTime || (duration == maxTime && keysPressed[i] < hardestChar)) {
                maxTime = duration;
                hardestChar = keysPressed[i];
            }
            prevTime = releaseTimes[i];
        }

        return hardestChar;
    }
};