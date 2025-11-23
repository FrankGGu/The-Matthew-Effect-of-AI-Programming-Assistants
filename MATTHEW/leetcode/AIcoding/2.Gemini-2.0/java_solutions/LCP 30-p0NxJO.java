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

        PriorityQueue<Integer> pq = new PriorityQueue<>();
        long hp = 1;
        int moves = 0;
        for (int num : nums) {
            hp += num;
            if (num < 0) {
                pq.offer(num);
            }
            while (hp <= 0) {
                hp -= pq.poll();
                moves++;
            }
        }

        return moves;
    }
}