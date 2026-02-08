import java.util.Arrays;

class Solution {
    public int minTime(int[] times) {
        Arrays.sort(times);
        int n = times.length;
        int totalTime = 0;

        while (n > 3) {
            // Strategy 1: The two fastest shuttle the two slowest.
            // 1. A, B cross (B)
            // 2. A returns (A)
            // 3. Y, Z cross (Z)
            // 4. B returns (B)
            // Total: B + A + Z + B
            int cost1 = times[1] + times[0] + times[n - 1] + times[1];

            // Strategy 2: The fastest person shuttles everyone.
            // 1. A, Z cross (Z)
            // 2. A returns (A)
            // 3. A, Y cross (Y)
            // 4. A returns (A)
            // Total: Z + A + Y + A
            int cost2 = times[n - 1] + times[0] + times[n - 2] + times[0];

            totalTime += Math.min(cost1, cost2);
            n -= 2; // Two people (the two slowest) have crossed permanently
        }

        // Handle remaining 1, 2, or 3 people
        if (n == 3) {
            // A, B cross (B) -> A returns (A) -> A, C cross (C)
            // Total: B + A + C
            totalTime += times[0] + times[1] + times[2];
        } else if (n == 2) {
            // A, B cross (B)
            // Total: B
            totalTime += times[1];
        } else if (n == 1) {
            // A crosses (A)
            // Total: A
            totalTime += times[0];
        }

        return totalTime;
    }
}