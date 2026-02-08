import java.util.HashMap;

public class Solution {
    public int lenLongestFibSubseq(int[] A) {
        int n = A.length;
        HashMap<Integer, Integer> index = new HashMap<>();
        for (int i = 0; i < n; i++) {
            index.put(A[i], i);
        }

        int maxLen = 0;
        for (int j = 1; j < n; j++) {
            for (int i = 0; i < j; i++) {
                int k = A[j] - A[i];
                if (k < A[i] && index.containsKey(k)) {
                    int len = 2;
                    int prev1 = A[i], prev2 = A[j];
                    while (index.containsKey(prev1 + prev2)) {
                        int next = prev1 + prev2;
                        len++;
                        prev1 = prev2;
                        prev2 = next;
                    }
                    maxLen = Math.max(maxLen, len);
                }
            }
        }
        return maxLen >= 3 ? maxLen : 0;
    }
}