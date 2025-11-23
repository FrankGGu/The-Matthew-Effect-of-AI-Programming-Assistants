import java.util.PriorityQueue;

class Solution {
    public int maximumProduct(int[] nums, int k) {
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        for (int num : nums) {
            minHeap.offer(num);
        }

        while (k-- > 0) {
            int smallest = minHeap.poll();
            minHeap.offer(smallest + 1);
        }

        long product = 1;
        for (int num : minHeap) {
            product = (product * num) % 1000000007;
        }

        return (int) product;
    }
}