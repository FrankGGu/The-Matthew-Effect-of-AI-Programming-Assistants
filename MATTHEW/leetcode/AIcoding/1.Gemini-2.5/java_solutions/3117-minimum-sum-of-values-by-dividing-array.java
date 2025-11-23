import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {

    static class SegmentTree {
        long[] tree;
        int N_seg;

        public SegmentTree(int size) {
            N_seg = size;
            tree = new long[2 * N_seg];
            Arrays.fill(tree, Long.MAX_VALUE / 2);
        }

        public void build(long[] arr) {
            for (int i = 0; i < N_seg; ++i) {
                tree[N_seg + i] = arr[i];
            }
            for (int i = N_seg - 1; i > 0; --i) {
                tree[i] = Math.min(tree[2 * i], tree[2 * i + 1]);
            }
        }

        public long query(int L, int R) {
            if (L > R) return Long.MAX_VALUE / 2;
            L += N_seg;
            R += N_seg;
            long res = Long.MAX_VALUE / 2;
            while (L <= R) {
                if ((L & 1) == 1) {
                    res = Math.min(res, tree[L]);
                    L++;
                }
                if ((R & 1) == 0) {
                    res = Math.min(res, tree[R]);
                    R--;
                }
                L /= 2;
                R /= 2;
            }
            return res;
        }
    }

    public long minimumSum(int[] nums, int[] andValues) {
        int n = nums.length;
        int m = andValues.length;

        long[] dp_prev = new long[n + 1];
        long[] dp_curr = new long[n + 1];

        Arrays.fill(dp_prev, Long.MAX_VALUE / 2);
        dp_prev[0] = 0;

        for (int j = 1; j <= m; ++j) {
            Arrays.fill(dp_curr, Long.MAX_VALUE / 2);
            int target_and = andValues[j - 1];

            SegmentTree segTree = new SegmentTree(n + 1);
            segTree.build(dp_prev);

            List<int[]> currentAndValuesList = new ArrayList<>();

            for (int i = 1; i <= n; ++i) {
                List<int[]> nextAndValuesList = new ArrayList<>();
                nextAndValuesList.add(new int[]{nums[i - 1], i - 1});

                for (int[] pair : currentAndValuesList) {
                    int val = pair[0];
                    int p_start = pair[1];
                    int new_val = val & nums[i - 1];
                    if (new_val != nextAndValuesList.get(nextAndValuesList.size() - 1)[0]) {
                        nextAndValuesList.add(new int[]{new_val, p_start});
                    }
                }
                currentAndValuesList = nextAndValuesList;

                long min_current_sum = Long.MAX_VALUE / 2;

                for (int x = 0; x < currentAndValuesList.size(); ++x) {
                    int current_and_val = currentAndValuesList.get(x)[0];
                    int p_start = currentAndValuesList.get(x)[1];

                    int p_end_exclusive;
                    if (x == 0) {
                        p_end_exclusive = i;
                    } else {
                        p_end_exclusive = currentAndValuesList.get(x - 1)[1];
                    }

                    if (current_and_val >= target_and) {
                        long min_dp_prev_in_range = segTree.query(p_start, p_end_exclusive - 1);
                        if (min_dp_prev_in_range != Long.MAX_VALUE / 2) {
                            min_current_sum = Math.min(min_current_sum, min_dp_prev_in_range + current_and_val);
                        }
                    }
                }
                dp_curr[i] = min_current_sum;
            }
            dp_prev = dp_curr;
        }

        return dp_prev[n] == Long.MAX_VALUE / 2 ? -1 : dp_prev[n];
    }
}