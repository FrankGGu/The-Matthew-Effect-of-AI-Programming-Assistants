import java.util.*;

class Solution {
    public List<Integer> busiestServers(int k, int[] arrival, int[] load) {
        int[] count = new int[k];
        PriorityQueue<int[]> busy = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        TreeSet<Integer> available = new TreeSet<>();
        for (int i = 0; i < k; i++) {
            available.add(i);
        }
        int max = 0;
        for (int i = 0; i < arrival.length; i++) {
            int time = arrival[i];
            int end = time + load[i];
            while (!busy.isEmpty() && busy.peek()[1] <= time) {
                int freed = busy.poll()[0];
                available.add(freed);
            }
            if (available.isEmpty()) {
                continue;
            }
            Integer server = available.ceiling(i % k);
            if (server == null) {
                server = available.first();
            }
            available.remove(server);
            busy.offer(new int[]{server, end});
            count[server]++;
            max = Math.max(max, count[server]);
        }
        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < k; i++) {
            if (count[i] == max) {
                result.add(i);
            }
        }
        return result;
    }
}