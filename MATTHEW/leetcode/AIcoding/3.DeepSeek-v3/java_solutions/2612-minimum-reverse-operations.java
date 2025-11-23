import java.util.*;

class Solution {
    public int[] minReverseOperations(int n, int p, int[] banned, int k) {
        int[] res = new int[n];
        Arrays.fill(res, -1);
        res[p] = 0;
        Set<Integer> bannedSet = new HashSet<>();
        for (int num : banned) {
            bannedSet.add(num);
        }

        TreeSet<Integer> even = new TreeSet<>();
        TreeSet<Integer> odd = new TreeSet<>();
        for (int i = 0; i < n; i++) {
            if (i != p && !bannedSet.contains(i)) {
                if (i % 2 == 0) {
                    even.add(i);
                } else {
                    odd.add(i);
                }
            }
        }

        Queue<Integer> queue = new LinkedList<>();
        queue.offer(p);

        while (!queue.isEmpty()) {
            int current = queue.poll();
            int left = Math.max(0, current - k + 1);
            int right = Math.min(current, n - k);

            int low = left + (k - 1) - current;
            int high = right + (k - 1) - current;

            TreeSet<Integer> set = (low % 2 == 0) ? even : odd;
            Integer next = set.ceiling(low);
            while (next != null && next <= high) {
                res[next] = res[current] + 1;
                queue.offer(next);
                set.remove(next);
                next = set.ceiling(low);
            }
        }

        return res;
    }
}