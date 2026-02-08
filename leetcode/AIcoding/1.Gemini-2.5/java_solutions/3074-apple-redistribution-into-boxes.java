import java.util.Arrays;
import java.util.Collections;

class Solution {
    public int minimumBoxes(int[] apple, int[] capacity) {
        int totalApples = 0;
        for (int a : apple) {
            totalApples += a;
        }

        Integer[] capacityObj = new Integer[capacity.length];
        for (int i = 0; i < capacity.length; i++) {
            capacityObj[i] = capacity[i];
        }

        Arrays.sort(capacityObj, Collections.reverseOrder());

        int boxesUsed = 0;
        int currentCapacity = 0;
        for (int cap : capacityObj) {
            currentCapacity += cap;
            boxesUsed++;
            if (currentCapacity >= totalApples) {
                break;
            }
        }
        return boxesUsed;
    }
}