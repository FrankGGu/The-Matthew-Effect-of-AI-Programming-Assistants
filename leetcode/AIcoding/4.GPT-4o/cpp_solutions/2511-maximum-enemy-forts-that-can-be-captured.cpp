class Solution {
public:
    int captureForts(vector<int>& forts) {
        int maxCaptured = 0, currentCaptured = 0;
        bool hasEnemy = false;

        for (int fort : forts) {
            if (fort == 1) {
                hasEnemy = true;
                currentCaptured = 0;
            } else if (fort == -1) {
                if (hasEnemy) {
                    maxCaptured = max(maxCaptured, currentCaptured);
                }
                hasEnemy = false;
                currentCaptured = 0;
            } else {
                currentCaptured++;
            }
        }

        return maxCaptured;
    }
};