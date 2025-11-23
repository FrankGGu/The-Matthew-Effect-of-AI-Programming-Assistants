import java.util.HashMap;

public class Solution {
    public int subarraysWithKDistinct(int[] A, int K) {
        return atMostK(A, K) - atMostK(A, K - 1);
    }

    private int atMostK(int[] A, int K) {
        HashMap<Integer, Integer> count = new HashMap<>();
        int left = 0, result = 0;

        for (int right = 0; right < A.length; right++) {
            if (count.put(A[right], count.getOrDefault(A[right], 0) + 1) == null) {
                K--;
            }
            while (K < 0) {
                if (count.put(A[left], count.get(A[left]) - 1) == 1) {
                    K++;
                }
                left++;
            }
            result += right - left + 1;
        }
        return result;
    }
}