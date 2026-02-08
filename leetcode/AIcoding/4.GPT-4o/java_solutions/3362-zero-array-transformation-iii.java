class Solution {
    public boolean canTransform(int[] arr) {
        int n = arr.length;
        int sum = 0;
        for (int num : arr) {
            sum += num;
        }
        if (sum != 0) return false;

        int prefixSum = 0;
        for (int num : arr) {
            prefixSum += num;
            if (prefixSum < 0) return false;
        }

        return true;
    }
}