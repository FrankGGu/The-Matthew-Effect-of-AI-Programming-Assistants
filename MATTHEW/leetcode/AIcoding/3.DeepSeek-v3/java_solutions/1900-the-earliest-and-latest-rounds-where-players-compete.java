class Solution {
    private int first;
    private int last;
    private int n;

    public int[] earliestAndLatest(int n, int firstPlayer, int secondPlayer) {
        this.first = Math.min(firstPlayer, secondPlayer);
        this.last = Math.max(firstPlayer, secondPlayer);
        this.n = n;
        int[] res = new int[]{n, 1};
        dfs(1, n, 1, 0, 0);
        res[0] = this.first;
        res[1] = this.last;
        return res;
    }

    private void dfs(int l, int r, int round, int maskL, int maskR) {
        if (l >= r) {
            if (l == r) {
                int nextL = l + Integer.bitCount(maskL);
                int nextR = r - Integer.bitCount(maskR);
                if (nextL > nextR) {
                    dfs(1, n, round + 1, 0, 0);
                } else {
                    dfs(nextL, nextR, round + 1, 0, 0);
                }
            }
            return;
        }

        if (l == first && r == last) {
            first = Math.min(first, round);
            last = Math.max(last, round);
            return;
        }

        if (l != first && l != last && r != first && r != last) {
            dfs(l + 1, r - 1, round, maskL, maskR);
        } else if (l == first || l == last) {
            dfs(l, r - 1, round, maskL, maskR | (1 << (n - r)));
        } else if (r == first || r == last) {
            dfs(l + 1, r, round, maskL | (1 << (l - 1)), maskR);
        }
    }
}