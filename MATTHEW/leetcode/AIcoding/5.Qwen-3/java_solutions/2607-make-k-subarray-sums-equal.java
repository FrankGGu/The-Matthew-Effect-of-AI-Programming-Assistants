public class Solution {

import java.util.*;

public class Solution {
    public int makeKSubarraySumsEqual(int[] arr, int k) {
        int n = arr.length;
        int[] freq = new int[26];
        for (int i = 0; i < n; i += k) {
            for (int j = 0; j < k && i + j < n; j++) {
                freq[arr[i + j] - 'a']++;
            }
        }
        int maxFreq = 0;
        for (int f : freq) {
            maxFreq = Math.max(maxFreq, f);
        }
        return n - maxFreq;
    }
}
}