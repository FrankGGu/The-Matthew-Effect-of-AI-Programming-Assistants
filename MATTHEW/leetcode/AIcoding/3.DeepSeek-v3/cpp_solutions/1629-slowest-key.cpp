class Solution {
public:
    char slowestKey(vector<int>& releaseTimes, string keysPressed) {
        int maxDuration = releaseTimes[0];
        char result = keysPressed[0];

        for (int i = 1; i < releaseTimes.size(); ++i) {
            int duration = releaseTimes[i] - releaseTimes[i-1];
            if (duration > maxDuration) {
                maxDuration = duration;
                result = keysPressed[i];
            } else if (duration == maxDuration && keysPressed[i] > result) {
                result = keysPressed[i];
            }
        }

        return result;
    }
};