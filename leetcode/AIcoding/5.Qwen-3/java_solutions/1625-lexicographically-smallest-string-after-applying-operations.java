public class Solution {
    public String lexSmallestString(String s) {
        char[] arr = s.toCharArray();
        int n = arr.length;

        for (int i = 0; i < n; i++) {
            if (i > 0 && arr[i] < arr[i - 1]) {
                break;
            }
            if (i == 0 || arr[i] != arr[i - 1]) {
                for (int j = i + 1; j < n; j++) {
                    if (arr[j] < arr[j - 1]) {
                        break;
                    }
                }
            }
        }

        for (int i = 0; i < n; i++) {
            if (i > 0 && arr[i] < arr[i - 1]) {
                break;
            }
            if (i == 0 || arr[i] != arr[i - 1]) {
                for (int j = i + 1; j < n; j++) {
                    if (arr[j] < arr[j - 1]) {
                        break;
                    }
                }
            }
        }

        return new String(arr);
    }
}