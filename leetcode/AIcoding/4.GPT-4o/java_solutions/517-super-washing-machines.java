public class Solution {
    public int findMinMoves(int[] machines) {
        int n = machines.length;
        int total = 0;
        for (int m : machines) {
            total += m;
        }
        if (total % n != 0) return -1;
        int target = total / n;
        int maxMoves = 0, sum = 0;

        for (int m : machines) {
            sum += m - target;
            maxMoves = Math.max(maxMoves, Math.max(Math.abs(sum), m - target));
        }

        return maxMoves;
    }
}