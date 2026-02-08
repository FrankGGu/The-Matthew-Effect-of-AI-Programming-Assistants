import java.util.Arrays;

class Solution {
    public double trimMean(int[] arr) {
        Arrays.sort(arr);
        int n = arr.length;
        int removeCount = n / 20;
        double sum = 0;
        int count = 0;

        for (int i = removeCount; i < n - removeCount; i++) {
            sum += arr[i];
            count++;
        }

        return sum / count;
    }
}