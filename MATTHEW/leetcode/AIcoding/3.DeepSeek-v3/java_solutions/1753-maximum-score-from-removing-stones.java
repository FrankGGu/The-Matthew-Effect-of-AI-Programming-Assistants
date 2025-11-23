class Solution {
    public int maximumScore(int a, int b, int c) {
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((x, y) -> y - x);
        maxHeap.offer(a);
        maxHeap.offer(b);
        maxHeap.offer(c);
        int score = 0;
        while (true) {
            int first = maxHeap.poll();
            int second = maxHeap.poll();
            if (second == 0) {
                break;
            }
            score++;
            maxHeap.offer(first - 1);
            maxHeap.offer(second - 1);
        }
        return score;
    }
}