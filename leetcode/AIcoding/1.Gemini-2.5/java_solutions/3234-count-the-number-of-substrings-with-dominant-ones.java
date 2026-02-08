class Solution {
    private static class FenwickTree {
        int[] bit;
        int N;

        public FenwickTree(int maxPossibleValue) {
            this.N = maxPossibleValue + 1;
            bit = new int[N + 1];
        }

        public void update(int idx, int val) {
            idx++; 
            while (idx <= N) {
                bit[idx] += val;
                idx += idx & (-idx);
            }
        }

        public int query(int idx) {
            idx++; 
            int sum = 0;
            while (idx > 0) {
                sum += bit[idx];
                idx -= idx & (-idx);
            }
            return sum;
        }
    }

    public long numberOfSubstrings(String s) {
        int n = s.length();
        long ans = 0;
        int currentSum = 0; 

        FenwickTree ft = new FenwickTree(2 * n);

        ft.update(0 + n, 1);

        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '1') {
                currentSum++;
            } else {
                currentSum--;
            }

            ans += ft.query(currentSum + n);

            ft.update(currentSum + n, 1);
        }

        return ans;
    }
}