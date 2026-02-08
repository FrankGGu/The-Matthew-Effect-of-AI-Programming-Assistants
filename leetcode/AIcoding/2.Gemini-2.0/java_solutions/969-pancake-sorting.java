import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> pancakeSort(int[] arr) {
        List<Integer> result = new ArrayList<>();
        int n = arr.length;

        for (int i = n; i > 1; i--) {
            int maxIndex = 0;
            for (int j = 1; j < i; j++) {
                if (arr[j] > arr[maxIndex]) {
                    maxIndex = j;
                }
            }

            if (maxIndex != i - 1) {
                if (maxIndex != 0) {
                    flip(arr, maxIndex + 1);
                    result.add(maxIndex + 1);
                }
                flip(arr, i);
                result.add(i);
            }
        }

        return result;
    }

    private void flip(int[] arr, int k) {
        int left = 0;
        int right = k - 1;
        while (left < right) {
            int temp = arr[left];
            arr[left] = arr[right];
            arr[right] = temp;
            left++;
            right--;
        }
    }
}