public class Solution {
    public int[] decode(int[] encoded, int first) {
        int n = encoded.length;
        int[] result = new int[n + 1];
        result[0] = first;
        for (int i = 0; i < n; i++) {
            result[i + 1] = result[i] ^ encoded[i];
        }
        return result;
    }
}