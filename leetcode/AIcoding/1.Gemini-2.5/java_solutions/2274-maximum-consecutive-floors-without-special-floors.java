import java.util.Arrays;

class Solution {
    public int maxConsecutive(int bottom, int top, int[] special) {
        Arrays.sort(special);

        int maxConsecutiveFloors = 0;

        maxConsecutiveFloors = Math.max(maxConsecutiveFloors, special[0] - bottom);

        for (int i = 0; i < special.length - 1; i++) {
            maxConsecutiveFloors = Math.max(maxConsecutiveFloors, special[i+1] - special[i] - 1);
        }

        maxConsecutiveFloors = Math.max(maxConsecutiveFloors, top - special[special.length - 1]);

        return maxConsecutiveFloors;
    }
}