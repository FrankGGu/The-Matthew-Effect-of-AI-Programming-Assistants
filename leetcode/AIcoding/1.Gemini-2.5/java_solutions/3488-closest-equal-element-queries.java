import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {

    static class SegmentTree {
        int[] tree;
        int N_seg;

        SegmentTree(int n) {
            N_seg = n;
            tree = new int[4 * N_seg];
            Arrays.fill(tree, Integer.MAX_VALUE);
        }

        void update(int idx, int val) {
            update(1, 0, N_seg - 1, idx, val);
        }

        private void update(int node, int start, int end, int idx, int val) {
            if (start == end) {
                tree[node] = val;
                return;
            }
            int mid = (start + end) / 2;
            if (start <= idx && idx <= mid) {
                update(2 * node, start, mid, idx, val);
            } else {
                update(2 * node + 1, mid + 1, end, idx, val);
            }
            tree[node] = Math.min(tree[2 * node], tree[2 * node + 1]);
        }

        int query(int l, int r) {
            if (l > r) {
                return Integer.MAX_VALUE;
            }
            return query(1, 0, N_seg - 1, l, r);
        }

        private int query(int node, int start, int end, int l, int r) {
            if (r < start || end < l) {
                return Integer.MAX_VALUE;
            }
            if (l <= start && end <= r) {
                return tree[node];
            }
            int mid = (start + end) / 2;
            int p1 = query(2 * node, start, mid, l, r);
            int p2 = query(2 * node + 1, mid + 1, end, l, r);
            return Math.min(p1, p2);
        }
    }

    static class Query {
        int L, R, originalIndex;

        Query(int L, int R, int originalIndex) {
            this.L = L;
            this.R = R;
            this.originalIndex = originalIndex;
        }
    }

    public int[] closestEqualElementQueries(int[] nums, int[][] queries) {
        int N = nums.length;
        int Q = queries.length;

        int[] prev = new int[N];
        Map<Integer, Integer> lastSeen = new HashMap<>();
        for (int i = 0; i < N; i++) {
            prev[i] = lastSeen.getOrDefault(nums[i], -1);
            lastSeen.put(nums[i], i);
        }

        List<Query>[] queriesAtR = new List[N];
        for (int k = 0; k < Q; k++) {
            int L = queries[k][0];
            int R = queries[k][1];
            if (queriesAtR[R] == null) {
                queriesAtR[R] = new ArrayList<>();
            }
            queriesAtR[R].add(new Query(L, R, k));
        }

        SegmentTree st = new SegmentTree(N);

        int[] answers = new int[Q];
        Arrays.fill(answers, -1);

        for (int j = 0; j < N; j++) {
            if (prev[j] != -1) {
                st.update(prev[j], j - prev[j]);
            }

            if (queriesAtR[j] != null) {
                for (Query q : queriesAtR[j]) {
                    int min_dist = st.query(q.L, q.R - 1);
                    if (min_dist != Integer.MAX_VALUE) {
                        answers[q.originalIndex] = min_dist;
                    }
                }
            }
        }

        return answers;
    }
}