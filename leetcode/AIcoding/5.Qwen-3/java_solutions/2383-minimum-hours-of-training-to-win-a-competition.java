public class Solution {
    public int minTrainingHours(int[] energy, int[] experience) {
        int n = energy.length;
        int total = 0;
        for (int i = 0; i < n; i++) {
            if (i == 0) {
                total += energy[i];
            } else {
                if (experience[i] <= experience[i - 1]) {
                    total += energy[i];
                } else {
                    total += energy[i] + (experience[i] - experience[i - 1]);
                    experience[i] = experience[i - 1] + 1;
                }
            }
        }
        return total;
    }
}