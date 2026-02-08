public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> pancakeSort(int[] A) {
        List<Integer> result = new ArrayList<>();
        int n = A.length;

        for (int i = n; i > 1; i--) {
            int maxIndex = 0;
            for (int j = 0; j < i; j++) {
                if (A[j] > A[maxIndex]) {
                    maxIndex = j;
                }
            }

            if (maxIndex == i - 1) {
                continue;
            }

            if (maxIndex != 0) {
                reverse(A, 0, maxIndex);
                result.add(maxIndex + 1);
            }

            reverse(A, 0, i - 1);
            result.add(i);
        }

        return result;
    }

    private void reverse(int[] A, int start, int end) {
        while (start < end) {
            int temp = A[start];
            A[start] = A[end];
            A[end] = temp;
            start++;
            end--;
        }
    }
}
}