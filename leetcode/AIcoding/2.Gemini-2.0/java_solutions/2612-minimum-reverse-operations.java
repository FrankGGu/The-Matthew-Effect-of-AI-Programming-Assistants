import java.util.*;

class Solution {
    public int[] minReverseOperations(int n, int p, int[] banned, int k) {
        int[] ans = new int[n];
        Arrays.fill(ans, -1);
        ans[p] = 0;

        Set<Integer> bannedSet = new HashSet<>();
        for (int b : banned) {
            bannedSet.add(b);
        }
        bannedSet.add(p);

        TreeSet<Integer>[] available = new TreeSet[2];
        available[0] = new TreeSet<>();
        available[1] = new TreeSet<>();

        for (int i = 0; i < n; i++) {
            if (!bannedSet.contains(i)) {
                available[i % 2].add(i);
            }
        }

        Queue<Integer> q = new LinkedList<>();
        q.offer(p);

        int steps = 0;
        while (!q.isEmpty()) {
            int size = q.size();
            for (int i = 0; i < size; i++) {
                int curr = q.poll();
                int lowerBound = Math.max(0, curr - (k - 1));
                int upperBound = Math.min(n - 1, curr + (k - 1));

                int minCenter = Math.max(0, k - 1 - curr);
                int maxCenter = Math.min(n - k, n - 1 - curr);

                int start = Math.max(lowerBound, 2 * minCenter - curr);
                if ((start - lowerBound) % 2 != 0) {
                    start++;
                }

                int end = Math.min(upperBound, 2 * maxCenter - curr);
                if ((end - lowerBound) % 2 != 0) {
                    end--;
                }

                if (start <= end) {
                    TreeSet<Integer> candidates = available[start % 2];
                    SortedSet<Integer> reachable = candidates.subSet(start, true, end, true);
                    Set<Integer> toRemove = new HashSet<>();

                    for (int next : reachable) {
                        ans[next] = steps + 1;
                        q.offer(next);
                        toRemove.add(next);
                    }

                    for(int remove : toRemove){
                        available[start % 2].remove(remove);
                    }

                }
            }
            steps++;
        }

        return ans;
    }
}