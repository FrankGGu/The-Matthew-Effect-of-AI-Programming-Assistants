#include <vector>
#include <string>

using namespace std;

char slowestKey(vector<int>& releaseTimes, string keysPressed) {
    int maxDuration = 0;
    char result = keysPressed[0];

    for (int i = 0; i < releaseTimes.size(); ++i) {
        int duration = (i == 0) ? releaseTimes[i] : releaseTimes[i] - releaseTimes[i - 1];
        if (duration > maxDuration || (duration == maxDuration && keysPressed[i] > result)) {
            maxDuration = duration;
            result = keysPressed[i];
        }
    }

    return result;
}