import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> pancakeSort(int[] arr) {
        List<Integer> result = new ArrayList<>();
        int n = arr.length;

        for (int i = n; i >= 1; i--) {
            int j = find(arr, i);

            if (j != i - 1) {
                if (j != 0) {
                    flip(arr, j + 1);
                    result.add(j + 1);
                }

                flip(arr, i);
                result.add(i);
            }
        }
        return result;
    }

    private int find(int[] arr, int target) {
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == target) {
                return i;
            }
        }
        return -1;
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