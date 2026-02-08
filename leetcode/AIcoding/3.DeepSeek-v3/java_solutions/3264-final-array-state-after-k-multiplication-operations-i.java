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
        while (!minHeap.isEmpty()) {
            product = (product * minHeap.poll()) % 1000000007;
        }
        return (int) product;
    }
}