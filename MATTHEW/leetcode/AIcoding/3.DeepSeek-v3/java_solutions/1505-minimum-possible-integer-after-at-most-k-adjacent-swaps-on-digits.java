class Solution {
    public String minInteger(String num, int k) {
        char[] arr = num.toCharArray();
        int n = arr.length;
        for (int i = 0; i < n && k > 0; i++) {
            int minIndex = i;
            for (int j = i + 1; j < n && j - i <= k; j++) {
                if (arr[j] < arr[minIndex]) {
                    minIndex = j;
                }
            }
            if (minIndex != i) {
                char temp = arr[minIndex];
                System.arraycopy(arr, i, arr, i + 1, minIndex - i);
                arr[i] = temp;
                k -= (minIndex - i);
            }
        }
        return new String(arr);
    }
}