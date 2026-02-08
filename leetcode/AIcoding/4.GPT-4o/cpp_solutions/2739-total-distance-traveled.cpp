class Solution {
public:
    int distanceTraveled(int mainTank, int additionalTank) {
        int totalDistance = 0;
        int maxDistance = mainTank * 5;
        int usableTank = min(mainTank, 20);

        totalDistance += usableTank * 5;

        if (mainTank > 20) {
            int extraDistance = min(additionalTank, (mainTank - 20));
            totalDistance += extraDistance * 5;
        }

        return totalDistance;
    }
};