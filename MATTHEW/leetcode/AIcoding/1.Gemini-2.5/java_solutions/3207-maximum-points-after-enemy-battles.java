import java.util.Arrays;

class Solution {
    public long maximumPoints(int[] energy, int currentEnergy) {
        if (energy == null || energy.length == 0) {
            return 0;
        }

        Arrays.sort(energy);

        long score = 0;
        long currentEnergyLong = currentEnergy;

        int left = 0;
        int right = energy.length - 1;

        while (left <= right) {
            if (currentEnergyLong >= energy[left]) {
                currentEnergyLong -= energy[left];
                score++;
                left++;
            } else if (score > 0 && left < right) {
                currentEnergyLong += energy[right];
                score--;
                right--;
            } else {
                break;
            }
        }

        return score;
    }
}