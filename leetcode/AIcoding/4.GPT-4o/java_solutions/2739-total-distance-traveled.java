public class Solution {
    public int distanceTraveled(int mainTank, int additionalTank) {
        int distance = 0;
        int maxDistance = Math.min(mainTank, 5);
        distance += maxDistance * 10;
        mainTank -= maxDistance;

        if (mainTank > 0) {
            int additionalDistance = Math.min(mainTank / 2, additionalTank);
            distance += additionalDistance * 10;
        }

        return distance;
    }
}