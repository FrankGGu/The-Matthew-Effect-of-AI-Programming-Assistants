import java.util.ArrayList;
import java.util.List;

class Solution {

    private static class BIT {
        int[] tree;
        int size;

        public BIT(int n) {
            size = n;
            tree = new int[n + 1];
        }

        public void update(int original_idx, int val) {
            original_idx++;
            while (original_idx <= size) {
                tree[original_idx] += val;
                original_idx += original_idx & (-original_idx);
            }
        }

        public int query(int original_idx) {
            int sum = 0;
            while (original_idx > 0) {
                sum += tree[original_idx];
                original_idx -= original_idx & (-original_idx);
            }
            return sum;
        }
    }

    public String minInteger(String num, int k) {
        int n = num.length();

        List<Integer>[] pos = new List[10];
        for (int i = 0; i < 10; i++) {
            pos[i] = new ArrayList<>();
        }

        for (int i = 0; i < n; i++) {
            pos[num.charAt(i) - '0'].add(i);
        }

        int[] ptr = new int[10];

        StringBuilder result = new StringBuilder();
        BIT bit = new BIT(n);

        for (int i = 0; i < n; i++) {
            for (int d = 0; d <= 9; d++) {
                if (ptr[d] < pos[d].size()) {
                    int original_idx = pos[d].get(ptr[d]);

                    int swaps_needed = original_idx - bit.query(original_idx);

                    if (swaps_needed <= k) {
                        result.append(d);
                        k -= swaps_needed;
                        bit.update(original_idx, 1);
                        ptr[d]++;
                        break;
                    }
                }
            }
        }

        return result.toString();
    }
}