class Solution {
    public long maxKelements(int[] nums, int k) {
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
        for (int num : nums) {
            maxHeap.offer(num);
        }
        long score = 0;
        for (int i = 0; i < k; i++) {
            int max = maxHeap.poll();
            score += max;
            maxHeap.offer((int) Math.ceil(max / 3.0));
        }
        return score;
    }
}