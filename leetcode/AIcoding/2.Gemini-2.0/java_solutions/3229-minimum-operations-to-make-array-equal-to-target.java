class Solution {
    public int minOperations(int[] nums, int target) {
        PriorityQueue<Long> pq = new PriorityQueue<>();
        long sum = 0;
        for (int num : nums) {
            pq.offer((long) num);
            sum += num;
        }

        if (sum < target) {
            return -1;
        }

        int operations = 0;
        long currentTarget = target;

        while (currentTarget > 0) {
            long smallest = pq.poll();
            if (smallest <= currentTarget) {
                currentTarget -= smallest;
            } else {
                pq.offer(smallest / 2);
                pq.offer(smallest / 2);
                operations++;
            }
        }

        while (!pq.isEmpty()) {
            operations += Long.bitCount(pq.poll() - 1);
        }

        return operations;
    }
}