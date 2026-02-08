class Solution {
    public int reachNumber(int target) {
        target = Math.abs(target);
        int k = 0;
        int sum = 0;

        while (sum < target || (sum - target) % 2 != 0) {
            k++;
            sum += k;
        }

        return k;
    }
}