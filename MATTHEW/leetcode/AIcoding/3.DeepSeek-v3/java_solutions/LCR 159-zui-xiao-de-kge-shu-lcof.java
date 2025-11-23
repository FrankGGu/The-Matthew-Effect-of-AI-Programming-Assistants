class Solution {
    public int[] inventoryManagement(int[] stock, int cnt) {
        if (cnt == 0) return new int[0];
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
        for (int num : stock) {
            maxHeap.offer(num);
            if (maxHeap.size() > cnt) {
                maxHeap.poll();
            }
        }
        int[] res = new int[cnt];
        for (int i = cnt - 1; i >= 0; i--) {
            res[i] = maxHeap.poll();
        }
        return res;
    }
}