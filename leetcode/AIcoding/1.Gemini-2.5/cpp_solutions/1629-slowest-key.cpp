class Solution {
public:
    char slowestKey(std::vector<int>& releaseTimes, std::string keysPressed) {
        int n = releaseTimes.size();
        int maxDuration = releaseTimes[0];
        char slowestKeyChar = keysPressed[0];

        for (int i = 1; i < n; ++i) {
            int currentDuration = releaseTimes[i] - releaseTimes[i-1];
            char currentKeyChar = keysPressed[i];

            if (currentDuration > maxDuration) {
                maxDuration = currentDuration;
                slowestKeyChar = currentKeyChar;
            } else if (currentDuration == maxDuration) {
                if (currentKeyChar > slowestKeyChar) {
                    slowestKeyChar = currentKeyChar;
                }
            }
        }

        return slowestKeyChar;
    }
};