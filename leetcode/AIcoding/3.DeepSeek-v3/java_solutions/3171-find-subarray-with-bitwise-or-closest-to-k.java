class Solution {
    public int closestToTarget(int[] arr, int target) {
        int n = arr.length;
        int minDiff = Integer.MAX_VALUE;
        Set<Integer> prev = new HashSet<>();

        for (int num : arr) {
            Set<Integer> curr = new HashSet<>();
            curr.add(num);
            for (int val : prev) {
                curr.add(val | num);
            }
            for (int val : curr) {
                minDiff = Math.min(minDiff, Math.abs(val - target));
            }
            prev = curr;
        }

        return minDiff;
    }
}