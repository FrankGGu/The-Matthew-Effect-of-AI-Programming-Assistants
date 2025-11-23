import java.util.HashSet;
import java.util.Set;

class Solution {
    public int lenLongestFibSubseq(int[] arr) {
        int n = arr.length;
        Set<Integer> set = new HashSet<>();
        for (int num : arr) {
            set.add(num);
        }

        int maxLen = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int a = arr[i];
                int b = arr[j];
                int len = 2;
                while (set.contains(a + b)) {
                    int temp = b;
                    b = a + b;
                    a = temp;
                    len++;
                }
                maxLen = Math.max(maxLen, len);
            }
        }

        return maxLen > 2 ? maxLen : 0;
    }
}