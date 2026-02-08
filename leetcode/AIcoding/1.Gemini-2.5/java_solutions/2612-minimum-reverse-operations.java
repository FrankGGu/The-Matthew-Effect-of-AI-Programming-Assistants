import java.util.*;

class Solution {
    public int[] minimumReverseOperations(int n, int p, int[] banned, int k) {
        int[] ans = new int[n];
        Arrays.fill(ans, -1);

        Set<Integer> bannedSet = new HashSet<>();
        for (int b : banned) {
            bannedSet.add(b);
        }

        TreeSet<Integer> unvisitedNodes = new TreeSet<>();
        for (int i = 0; i < n; i++) {
            if (!bannedSet.contains(i)) {
                unvisitedNodes.add(i);
            }
        }

        unvisitedNodes.remove(p);

        Queue<Integer> queue = new LinkedList<>();

        ans[p] = 0;
        queue.offer(p);

        while (!queue.isEmpty()) {
            int u = queue.poll();
            int currentDist = ans[u];

            // Calculate the range of possible L values for a reverse operation
            // L is the start index of the k-length subarray [L, L+k-1]
            // Conditions for L:
            // 1. 0 <= L
            // 2. L+k-1 < n  =>  L <= n-k
            // 3. L <= u
            // 4. u <= L+k-1 => L >= u-k+1
            int L_min_bound = Math.max(0, u - k + 1);
            int L_max_bound = Math.min(u, n - k);

            // The new position v is L + (L+k-1) - u = 2L + k - 1 - u
            // Calculate the range of possible v values
            int target_range_start = 2 * L_min_bound + k - 1 - u;
            int target_range_end = 2 * L_max_bound + k - 1 - u;

            // All reachable v values from u have the same parity.
            // v = 2L + k - 1 - u. Parity of v is (k - 1 - u) % 2.
            // Or equivalently, (u + k - 1) % 2.
            int targetParity = (u + k - 1) % 2;

            List<Integer> toProcess = new ArrayList<>();

            // Find the first potential node in unvisitedNodes that is >= target_range_start
            Integer current_v_in_set = unvisitedNodes.ceiling(target_range_start);

            while (current_v_in_set != null && current_v_in_set <= target_range_end) {
                if (current_v_in_set % 2 == targetParity) {
                    toProcess.add(current_v_in_set);
                }
                current_v_in_set = unvisitedNodes.higher(current_v_in_set);
            }

            for (int v : toProcess) {
                ans[v] = currentDist + 1;
                queue.offer(v);
                unvisitedNodes.remove(v);
            }
        }

        return ans;
    }
}