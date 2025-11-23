import java.util.PriorityQueue;

class Solution {
    public int kthSmallest(int[] nums, int k) {
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        for (int num : nums) {
            pq.offer(num);
        }
        int[] amounts = new int[nums.length];
        for (int i = 0; i < nums.length; i++) {
            amounts[i] = pq.poll();
        }

        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        minHeap.offer(amounts[0]);

        boolean[][] visited = new boolean[nums.length][nums.length];
        visited[0][0] = true;

        int count = 0;
        int result = 0;

        while (count < k) {
            result = minHeap.poll();
            count++;

            for (int i = 0; i < nums.length; i++) {
                for (int j = 0; j < nums.length; j++) {
                    if (i > 0 && j > 0) continue;
                    if (i == 0 && j == 0) continue;

                    int newIndex1 = -1, newIndex2 = -1;

                    if(i > 0) newIndex1 = i;
                    if(j > 0) newIndex2 = j;

                    if (newIndex1 == -1 && newIndex2 == -1) continue;

                    if(newIndex1 != -1 && newIndex2 == -1) {
                        if (!visited[newIndex1][0]) {
                            minHeap.offer(amounts[newIndex1]);
                            visited[newIndex1][0] = true;
                        }
                    } else if (newIndex1 == -1 && newIndex2 != -1) {
                         if (!visited[0][newIndex2]) {
                            minHeap.offer(amounts[newIndex2]);
                            visited[0][newIndex2] = true;
                        }
                    } else {
                        //Should not happen
                    }
                }
            }

        }

        return result;
    }
}