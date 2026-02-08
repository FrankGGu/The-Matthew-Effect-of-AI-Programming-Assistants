class Solution {
    public int distanceTraveled(int mainTank, int additionalTank) {
        int distance = 0;
        while (mainTank > 0) {
            if (mainTank >= 5 && additionalTank > 0) {
                distance += 50;
                mainTank -= 5;
                additionalTank--;
            } else {
                distance += mainTank * 10;
                mainTank = 0;
            }
        }
        return distance;
    }
}