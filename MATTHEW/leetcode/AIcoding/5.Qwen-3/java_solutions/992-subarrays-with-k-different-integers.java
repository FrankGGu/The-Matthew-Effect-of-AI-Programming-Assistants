public class Solution {

import java.util.*;

public class Solution {
    public int subarraysWithKDistinct(int[] A, int K) {
        return atMostK(A, K) - atMostK(A, K - 1);
    }

    private int atMostK(int[] A, int K) {
        int left = 0, result = 0;
        Map<Integer, Integer> count = new HashMap<>();
        for (int right = 0; right < A.length; right++) {
            count.put(A[right], count.getOrDefault(A[right], 0) + 1);
            while (count.size() > K) {
                count.put(A[left], count.get(A[left]) - 1);
                if (count.get(A[left]) == 0) {
                    count.remove(A[left]);
                }
                left++;
            }
            result += right - left + 1;
        }
        return result;
    }
}
}