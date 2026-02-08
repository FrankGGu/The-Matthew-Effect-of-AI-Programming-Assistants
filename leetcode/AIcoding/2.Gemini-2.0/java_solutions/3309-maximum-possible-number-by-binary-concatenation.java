import java.util.Arrays;

class Solution {
    public int solve(int[] arr) {
        String[] s = new String[arr.length];
        for (int i = 0; i < arr.length; i++) {
            s[i] = String.valueOf(arr[i]);
        }
        Arrays.sort(s, (a, b) -> (b + a).compareTo(a + b));
        return Integer.parseInt(String.join("", s));
    }
}