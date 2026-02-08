public class Solution {
    public String lexSmallestString(String s, String a) {
        char[] arr = s.toCharArray();
        int n = arr.length;
        for (int i = 0; i < n; i++) {
            if (arr[i] != a.charAt(0)) continue;
            for (int j = i; j < n; j++) {
                if (arr[j] != a.charAt(j - i)) break;
                if (j == n - 1) return a;
            }
        }
        return s;
    }
}