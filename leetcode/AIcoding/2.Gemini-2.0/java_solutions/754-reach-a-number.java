class Solution {
    public int reachNumber(int target) {
        target = Math.abs(target);
        int sum = 0, steps = 0;
        while (sum < target) {
            steps++;
            sum += steps;
        }
        if ((sum - target) % 2 == 0) {
            return steps;
        } else {
            if (steps % 2 == 0) {
                return steps + 1;
            } else {
                return steps + 2;
            }
        }
    }
}