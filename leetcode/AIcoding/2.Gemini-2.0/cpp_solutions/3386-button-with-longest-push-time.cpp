#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    char slowestKey(vector<int>& releaseTimes, string keysPressed) {
        char slowest = keysPressed[0];
        int maxDuration = releaseTimes[0];

        for (int i = 1; i < releaseTimes.size(); ++i) {
            int duration = releaseTimes[i] - releaseTimes[i - 1];
            if (duration > maxDuration) {
                maxDuration = duration;
                slowest = keysPressed[i];
            } else if (duration == maxDuration && keysPressed[i] > slowest) {
                slowest = keysPressed[i];
            }
        }

        return slowest;
    }
};