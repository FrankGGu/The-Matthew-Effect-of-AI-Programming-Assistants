class Solution {
    private int maxTime = -1;
    private String result = "";

    public String largestTimeFromDigits(int[] A) {
        boolean[] used = new boolean[4];
        int[] currentPermutation = new int[4];

        permute(A, currentPermutation, used, 0);

        return result;
    }

    private void permute(int[] digits, int[] currentPermutation, boolean[] used, int index) {
        if (index == 4) {
            int h1 = currentPermutation[0];
            int h2 = currentPermutation[1];
            int m1 = currentPermutation[2];
            int m2 = currentPermutation[3];

            int hours = h1 * 10 + h2;
            int minutes = m1 * 10 + m2;

            if (hours >= 0 && hours <= 23 && minutes >= 0 && minutes <= 59) {
                int currentTimeInMinutes = hours * 60 + minutes;
                if (currentTimeInMinutes > maxTime) {
                    maxTime = currentTimeInMinutes;
                    result = String.format("%02d:%02d", hours, minutes);
                }
            }
            return;
        }

        for (int i = 0; i < 4; i++) {
            if (!used[i]) {
                used[i] = true;
                currentPermutation[index] = digits[i];
                permute(digits, currentPermutation, used, index + 1);
                used[i] = false; 
            }
        }
    }
}