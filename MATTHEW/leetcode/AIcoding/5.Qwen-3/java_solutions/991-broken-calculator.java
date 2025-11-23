public class Solution {
    public int brokenCalc(int target, int bomb) {
        int steps = 0;
        while (bomb < target) {
            bomb *= 2;
            steps++;
        }
        return steps + (bomb - target);
    }
}