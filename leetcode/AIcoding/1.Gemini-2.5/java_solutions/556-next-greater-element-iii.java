import java.util.Arrays;

class Solution {
    public int nextGreaterElement(int n) {
        char[] s = String.valueOf(n).toCharArray();
        int len = s.length;

        int k = len - 2;
        while (k >= 0 && s[k] >= s[k + 1]) {
            k--;
        }

        if (k < 0) {
            return -1;
        }

        int l = len - 1;
        while (l >= 0 && s[l] <= s[k]) {
            l--;
        }

        char temp = s[k];
        s[k] = s[l];
        s[l] = temp;

        reverse(s, k + 1, len - 1);

        long result = Long.parseLong(new String(s));

        if (result > Integer.MAX_VALUE) {
            return -1;
        }

        return (int) result;
    }

    private void reverse(char[] arr, int start, int end) {
        while (start < end) {
            char temp = arr[start];
            arr[start] = arr[end];
            arr[end] = temp;
            start++;
            end--;
        }
    }
}