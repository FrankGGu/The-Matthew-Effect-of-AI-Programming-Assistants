import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> findClosestElements(int[] arr, int k, int x) {
        int n = arr.length;

        int low = 0;
        int high = n - k; 

        while (low < high) {
            int mid = low + (high - low) / 2;

            if (Math.abs(x - arr[mid]) > Math.abs(x - arr[mid + k])) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }

        List<Integer> result = new ArrayList<>();
        for (int i = low; i < low + k; i++) {
            result.add(arr[i]);
        }

        return result;
    }
}