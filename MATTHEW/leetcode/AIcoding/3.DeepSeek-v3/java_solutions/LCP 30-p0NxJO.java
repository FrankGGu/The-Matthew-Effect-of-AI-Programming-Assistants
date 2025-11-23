import java.util.PriorityQueue;

class Solution {
    public int magicTower(int[] nums) {
        long sum = 0;
        for (int num : nums) {
            sum += num;
        }
        if (sum < 0) {
            return -1;
        }

        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        long hp = 1;
        int res = 0;
        for (int num : nums) {
            hp += num;
            if (num < 0) {
                minHeap.offer(num);
            }
            if (hp <= 0) {
                res++;
                hp -= minHeap.poll();
            }
        }
        return res;
    }
}