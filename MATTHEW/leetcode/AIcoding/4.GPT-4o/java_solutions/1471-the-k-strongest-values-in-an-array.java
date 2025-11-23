import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int[] getStrongest(int[] arr, int k) {
        Arrays.sort(arr);
        int n = arr.length;
        int median = arr[(n - 1) / 2];
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> Math.abs(a - median) == Math.abs(b - median) ? b - a : Math.abs(a - median) - Math.abs(b - median));

        for (int num : arr) {
            maxHeap.offer(num);
        }

        int[] result = new int[k];
        for (int i = 0; i < k; i++) {
            result[i] = maxHeap.poll();
        }

        return result;
    }
}