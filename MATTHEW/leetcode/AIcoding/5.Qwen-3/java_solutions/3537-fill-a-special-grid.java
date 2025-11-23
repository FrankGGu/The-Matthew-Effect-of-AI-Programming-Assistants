public class Solution {
    public int[] getColors(int n) {
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = i % 4;
        }
        return result;
    }
}