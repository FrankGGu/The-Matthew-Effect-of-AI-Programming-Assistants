class Solution {
public:
    int distanceTraveled(int mainTank, int additionalTank) {
        int totalDistance = 0;

        while (mainTank >= 5) {
            totalDistance += 50;
            mainTank -= 5;

            if (additionalTank > 0) {
                mainTank += 1;
                additionalTank -= 1;
            }
        }

        totalDistance += mainTank * 10;

        return totalDistance;
    }
};