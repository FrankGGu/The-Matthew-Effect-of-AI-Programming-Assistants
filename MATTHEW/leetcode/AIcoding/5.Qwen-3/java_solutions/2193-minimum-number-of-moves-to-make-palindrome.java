public class Solution {

import java.util.*;

public class Solution {
    public int minMovesToMakePalindrome(String s) {
        int n = s.length();
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }
        int res = 0;
        int left = 0, right = n - 1;
        char[] arr = s.toCharArray();
        while (left < right) {
            if (arr[left] == arr[right]) {
                left++;
                right--;
            } else {
                int i = right;
                while (i > left && arr[i] != arr[left]) {
                    i--;
                }
                if (i == left) {
                    swap(arr, left, left + 1);
                    res++;
                } else {
                    while (i < right) {
                        swap(arr, i, i + 1);
                        res++;
                        i++;
                    }
                    left++;
                    right--;
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