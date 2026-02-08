import java.util.HashSet;
import java.util.Set;

class Solution {
    public int[] fairCandySwap(int[] aliceSizes, int[] bobSizes) {
        int sumA = 0;
        for (int size : aliceSizes) {
            sumA += size;
        }

        int sumB = 0;
        Set<Integer> bobCandySet = new HashSet<>();
        for (int size : bobSizes) {
            sumB += size;
            bobCandySet.add(size);
        }

        int diff = (sumA - sumB) / 2;

        for (int aliceCandy : aliceSizes) {
            int bobRequiredCandy = aliceCandy - diff;
            if (bobCandySet.contains(bobRequiredCandy)) {
                return new int[]{aliceCandy, bobRequiredCandy};
            }
        }

        return new int[0]; // Should not reach here based on problem constraints
    }
}