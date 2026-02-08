import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> pancakeSort(int[] A) {
        List<Integer> result = new ArrayList<>();
        int n = A.length;

        for (int size = n; size > 1; size--) {
            int maxIndex = 0;
            for (int i = 1; i < size; i++) {
                if (A[i] > A[maxIndex]) {
                    maxIndex = i;
                }
            }
            if (maxIndex != size - 1) {
                if (maxIndex > 0) {
                    flip(A, maxIndex + 1);
                    result.add(maxIndex + 1);
                }
                flip(A, size);
                result.add(size);
            }
        }

        return result;
    }

    private void flip(int[] A, int k) {
        int left = 0, right = k - 1;
        while (left < right) {
            int temp = A[left];
            A[left] = A[right];
            A[right] = temp;
            left++;
            right--;
        }
    }
}