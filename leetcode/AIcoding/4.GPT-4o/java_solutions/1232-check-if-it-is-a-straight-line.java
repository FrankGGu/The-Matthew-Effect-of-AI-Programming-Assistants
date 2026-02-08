class Solution {
    public boolean checkStraightLine(int[][] coordinates) {
        if (coordinates.length < 2) return false;
        double slope = (double)(coordinates[1][1] - coordinates[0][1]) / (coordinates[1][0] - coordinates[0][0]);
        for (int i = 2; i < coordinates.length; i++) {
            double currentSlope = (double)(coordinates[i][1] - coordinates[0][1]) / (coordinates[i][0] - coordinates[0][0]);
            if (currentSlope != slope) return false;
        }
        return true;
    }
}