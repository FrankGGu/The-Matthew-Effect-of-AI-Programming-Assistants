import java.util.ArrayList;
import java.util.List;

class Solution {

    private class Pair {
        int value;
        int index;

        public Pair(int value, int index) {
            this.value = value;
            this.index = index;
        }
    }

    private List<Integer> counts;
    private Pair[] temp; // Auxiliary array for merge sort

    public List<Integer> countSmaller(int[] nums) {
        int n = nums.length;
        counts = new ArrayList<>(n);
        for (int i = 0; i < n; i++) {
            counts.add(0); // Initialize all counts to 0
        }

        Pair[] pairs = new Pair[n];
        for (int i = 0; i < n; i++) {
            pairs[i] = new Pair(nums[i], i);
        }

        temp = new Pair[n]; // Initialize temp array once

        mergeSort(pairs, 0, n - 1);

        return counts;
    }

    private void mergeSort(Pair[] arr, int low, int high) {
        if (low >= high) {
            return;
        }

        int mid = low + (high - low) / 2;
        mergeSort(arr, low, mid);
        mergeSort(arr, mid + 1, high);
        merge(arr, low, mid, high);
    }

    private void merge(Pair[] arr, int low, int mid, int high) {
        // Pointers for the two halves, starting from their rightmost elements
        int p1 = mid;
        int p2 = high;
        // Pointer for placing elements into the temporary array, starting from its rightmost
        int k = high;

        // While both halves have elements to compare
        while (p1 >= low && p2 >= mid + 1) {
            if (arr[p1].value > arr[p2].value) {
                // If element from left half is greater, it means all elements
                // currently in the right subarray (from mid+1 to p2) are smaller than arr[p1].
                // The count of smaller elements for arr[p1] is the number of elements
                // remaining in the right subarray.
                counts.set(arr[p1].index, counts.get(arr[p1].index) + (p2 - (mid + 1) + 1));
                temp[k--] = arr[p1--]; // Place arr[p1] into temp, then move p1 left
            } else {
                // If element from right half is greater or equal, it means arr[p2] is placed.
                // It does not contribute to counts for arr[p1] at this step.
                temp[k--] = arr[p2--]; // Place arr[p2] into temp, then move p2 left
            }
        }

        // Copy any remaining elements from the left half
        while (p1 >= low) {
            temp[k--] = arr[p1--];
        }

        // Copy any remaining elements from the right half
        while (p2 >= mid + 1) {
            temp[k--] = arr[p2--];
        }

        // Copy the merged and sorted elements from temp back to arr
        for (int idx = low; idx <= high; idx++) {
            arr[idx] = temp[idx];
        }
    }
}