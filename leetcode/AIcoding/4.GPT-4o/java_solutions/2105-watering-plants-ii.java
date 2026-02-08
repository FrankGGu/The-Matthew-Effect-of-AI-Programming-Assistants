class Solution {
    public int minimumHours(int[] A, int B, int C) {
        int n = A.length;
        int totalWater = 0;
        for (int i = 0; i < n; i++) {
            totalWater += A[i];
        }
        int hours = 0;
        while (totalWater > 0) {
            if (B > 0) {
                totalWater -= B;
            }
            hours++;
            if (C > 0) {
                B += C;
            }
        }
        return hours;
    }
}