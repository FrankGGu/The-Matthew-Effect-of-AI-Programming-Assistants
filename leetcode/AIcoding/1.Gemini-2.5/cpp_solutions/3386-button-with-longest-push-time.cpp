class Solution {
public:
    char slowestKey(std::vector<int>& releaseTimes, std::string keysPressed) {
        int n = releaseTimes.size();
        int maxDuration = releaseTimes[0];
        char resultChar = keysPressed[0];

        for (int i = 1; i < n; ++i) {
            int currentDuration = releaseTimes[i] - releaseTimes[i - 1];
            char currentKey = keysPressed[i];

            if (currentDuration > maxDuration) {
                maxDuration = currentDuration;
                resultChar = currentKey;
            } else if (currentDuration == maxDuration) {
                if (currentKey > resultChar) {
                    resultChar = currentKey;
                }
            }
        }

        return resultChar;
    }
};