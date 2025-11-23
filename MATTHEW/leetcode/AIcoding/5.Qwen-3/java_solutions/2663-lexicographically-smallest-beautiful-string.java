public class Solution {
    public String lexicographicalSmallestBeautifulString(String s) {
        int n = s.length();
        char[] arr = s.toCharArray();
        for (int i = n - 1; i >= 0; i--) {
            char c = arr[i];
            for (char next = (char) (c + 1); next <= 'z'; next++) {
                if (i > 0 && next == arr[i - 1]) continue;
                if (i > 1 && next == arr[i - 2]) continue;
                arr[i] = next;
                return new String(arr);
            }
        }
        return "";
    }
}