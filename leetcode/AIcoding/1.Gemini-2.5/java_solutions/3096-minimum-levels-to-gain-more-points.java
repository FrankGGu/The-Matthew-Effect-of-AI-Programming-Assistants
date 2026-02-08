class Solution {
    public int minimumLevels(int[] possible) {
        int n = possible.length;
        int totalScore = 0;
        for (int i = 0; i < n; i++) {
            if (possible[i] == 1) {
                totalScore += 1;
            } else {
                totalScore -= 1;
            }
        }

        int myPoints = 0;
        for (int k = 0; k < n - 1; k++) {
            if (possible[k] == 1) {
                myPoints += 1;
            } else {
                myPoints -= 1;
            }

            int friendPoints = totalScore - myPoints;

            if (myPoints > friendPoints) {
                return k + 1;
            }
        }
        return -1;
    }
}