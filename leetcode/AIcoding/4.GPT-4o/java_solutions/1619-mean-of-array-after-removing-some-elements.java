class Solution {
    public double trimMean(int[] arr) {
        Arrays.sort(arr);
        int n = arr.length;
        int trimCount = n / 20;
        double sum = 0;
        for (int i = trimCount; i < n - trimCount; i++) {
            sum += arr[i];
        }
        return sum / (n - 2 * trimCount);
    }
}