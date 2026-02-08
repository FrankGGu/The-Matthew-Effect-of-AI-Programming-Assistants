import java.util.PriorityQueue;

class Solution {
    public int inventoryManagement(int[] stock, int k) {
        PriorityQueue<Integer> pq = new PriorityQueue<>();

        for (int num : stock) {
            pq.add(num);
            if (pq.size() > k) {
                pq.poll();
            }
        }

        return pq.peek();
    }
}