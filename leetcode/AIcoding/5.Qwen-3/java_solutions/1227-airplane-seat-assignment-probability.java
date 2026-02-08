public class Solution {
    public double airplaneSeatAssignmentProbability(int n) {
        if (n == 1) return 1.0;
        return 1.0 / (n - 1);
    }
}