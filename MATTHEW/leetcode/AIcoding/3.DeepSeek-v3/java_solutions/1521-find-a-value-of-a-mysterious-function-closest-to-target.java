class Solution {
    public int closestToTarget(int[] arr, int target) {
        int res = Integer.MAX_VALUE;
        Set<Integer> set = new HashSet<>();
        for (int num : arr) {
            Set<Integer> temp = new HashSet<>();
            temp.add(num);
            for (int val : set) {
                temp.add(val & num);
            }
            for (int val : temp) {
                res = Math.min(res, Math.abs(val - target));
            }
            set = temp;
        }
        return res;
    }
}