import java.util.Arrays;

class Solution {
    public int[] findOriginalArray(int[] changed) {
        int n = changed.length;
        if (n % 2 != 0) {
            return new int[0];
        }

        int[] counts = new int[100001]; // Max value in changed array is 10^5
        for (int x : changed) {
            counts[x]++;
        }

        Arrays.sort(changed);

        int[] original = new int[n / 2];
        int originalIdx = 0;

        for (int num : changed) {
            if (counts[num] == 0) {
                continue;
            }

            counts[num]--; // Decrement count for the current number 'num'

            if (num == 0) {
                if (counts[0] > 0) { // If there's another 0 available to be its double
                    counts[0]--;
                    original[originalIdx++] = 0;
                } else { // Not enough 0s to form pairs
                    return new int[0];
                }
            } else { // For non-zero numbers
                int doubledNum = num * 2;
                if (doubledNum < counts.length && counts[doubledNum] > 0) {
                    counts[doubledNum]--;
                    original[originalIdx++] = num;
                } else { // Double not found or out of bounds
                    return new int[0];
                }
            }
        }

        return original;
    }
}