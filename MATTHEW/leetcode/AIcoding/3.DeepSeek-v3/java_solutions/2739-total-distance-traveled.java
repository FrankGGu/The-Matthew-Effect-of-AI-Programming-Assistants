class Solution {
    public int distanceTraveled(int mainTank, int additionalTank) {
        int distance = 0;
        while (mainTank > 0) {
            int used = Math.min(mainTank, 5);
            distance += used * 10;
            mainTank -= used;
            if (used == 5 && additionalTank > 0) {
                mainTank += 1;
                additionalTank -= 1;
            }
        }
        return distance;
    }
}