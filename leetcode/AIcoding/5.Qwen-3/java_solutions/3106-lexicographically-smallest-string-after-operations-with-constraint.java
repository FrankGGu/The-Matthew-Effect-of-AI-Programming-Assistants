public class Solution {
    public String lexSmallestString(String s) {
        char[] arr = s.toCharArray();
        int n = arr.length;
        for (int i = 0; i < n; i++) {
            if (arr[i] != '0') {
                break;
            }
            if (i == n - 1) {
                return "0";
            }
        }
        for (int i = 0; i < n; i++) {
            if (arr[i] != '0') {
                for (int j = i; j < n; j++) {
                    if (arr[j] == '0') {
                        break;
                    }
                    arr[j]--;
                }
                break;
            }
        }
        return new String(arr);
    }
}