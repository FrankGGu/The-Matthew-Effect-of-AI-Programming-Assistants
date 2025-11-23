public class Solution {
    public String lexSmallestString(String s) {
        char[] arr = s.toCharArray();
        int n = arr.length;
        for (int i = 0; i < n; i++) {
            if (arr[i] != '0') {
                for (int j = i + 1; j < n; j++) {
                    if (arr[j] == '0') {
                        swap(arr, i, j);
                        return new String(arr);
                    }
                }
                break;
            }
        }
        return new String(arr);
    }

    private void swap(char[] arr, int i, int j) {
        char temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}