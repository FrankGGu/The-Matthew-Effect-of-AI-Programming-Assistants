public class Solution {

import java.util.*;

public class Solution {
    public int minAdjacentSwaps(String s, int k) {
        char[] arr = s.toCharArray();
        int n = arr.length;
        int[] count = new int[n];
        Arrays.fill(count, 1);
        for (int i = n - 1; i > 0; i--) {
            for (int j = i - 1; j >= 0; j--) {
                if (arr[j] > arr[i]) {
                    count[j]++;
                }
            }
        }
        int res = 0;
        for (int i = 0; i < n && k > 0; i++) {
            for (int j = i + 1; j < n && k > 0; j++) {
                if (arr[i] > arr[j]) {
                    swap(arr, i, j);
                    res++;
                    k--;
                }
            }
        }
        return res;
    }

    private void swap(char[] arr, int i, int j) {
        char temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}
}