public class Solution {

import java.util.*;

public class Solution {
    public String findMinPossible(String num, int k) {
        char[] digits = num.toCharArray();
        int n = digits.length;
        boolean[] used = new boolean[n];
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < n; i++) {
            int pos = -1;
            for (int j = 0; j < n; j++) {
                if (!used[j]) {
                    if (pos == -1 || digits[j] < digits[pos]) {
                        pos = j;
                    }
                }
            }

            int swapCount = 0;
            for (int j = pos; j > i; j--) {
                if (swapCount < k) {
                    swap(digits, j, j - 1);
                    swapCount++;
                } else {
                    break;
                }
            }

            used[pos] = true;
            result.append(digits[i]);
        }

        return result.toString();
    }

    private void swap(char[] arr, int i, int j) {
        char temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}
}