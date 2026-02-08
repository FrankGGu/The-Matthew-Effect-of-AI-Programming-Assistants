class Solution {
    public boolean isPossible(int[] target) {
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        long total = 0;
        for (int num : target) {
            total += num;
            maxHeap.add(num);
        }

        while (!maxHeap.isEmpty()) {
            int max = maxHeap.poll();
            long remaining = total - max;

            if (max == 1 || remaining == 1) {
                return true;
            }
            if (remaining == 0 || max < remaining) {
                return false;
            }

            int newMax = (int)(max % remaining);
            if (newMax == 0) {
                return false;
            }

            maxHeap.add(newMax);
            total = remaining + newMax;
        }

        return true;
    }
}