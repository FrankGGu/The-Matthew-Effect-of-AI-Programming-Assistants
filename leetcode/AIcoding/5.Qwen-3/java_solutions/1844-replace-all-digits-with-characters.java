public class Solution {
    public String replaceDigits(int n, String s) {
        char[] arr = s.toCharArray();
        for (int i = 1; i < n; i += 2) {
            int shift = arr[i] - '0';
            arr[i] = (char) (arr[i - 1] + shift);
        }
        return new String(arr);
    }
}