class Solution {
    public int fillCups(int[] amount) {
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
        for (int num : amount) {
            if (num > 0) {
                maxHeap.offer(num);
            }
        }
        int time = 0;
        while (!maxHeap.isEmpty()) {
            int first = maxHeap.poll();
            int second = maxHeap.isEmpty() ? 0 : maxHeap.poll();
            first--;
            if (first > 0) {
                maxHeap.offer(first);
            }
            if (second > 0) {
                second--;
                if (second > 0) {
                    maxHeap.offer(second);
                }
            }
            time++;
        }
        return time;
    }
}