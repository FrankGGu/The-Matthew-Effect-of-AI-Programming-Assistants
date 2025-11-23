class Solution {
    public boolean canTransform(int[] arr) {
        int sum = 0;
        for (int num : arr) {
            sum += num;
        }
        return sum == 0;
    }
}