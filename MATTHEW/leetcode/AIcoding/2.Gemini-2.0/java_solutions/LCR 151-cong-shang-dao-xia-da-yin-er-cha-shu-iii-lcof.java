class Solution {
    public int[][] recordIllumination(int n, int[][] lamps, int[][] queries) {
        long[] diff = new long[n + 2];
        HashMap<Integer, Integer> map = new HashMap<>();
        for (int[] lamp : lamps) {
            int row = lamp[0], col = lamp[1];
            int hash = row * n + col;
            if (map.containsKey(hash)) continue;
            map.put(hash, 1);
            int left = Math.max(0, col - row);
            int right = Math.min(n - 1, n - 1 + col - row);
            diff[left + 1]++;
            diff[right + 2]--;

            left = Math.max(0, row + col - n + 1);
            right = Math.min(n - 1, row + col);
            diff[n + 2 + left]++;
            diff[n + 2 + right + 1]--;

            diff[2 * n + 4 + row + col]++;
            diff[2 * n + 4 + row + col + 1]--;

            diff[3 * n + 4 - row + col]++;
            diff[3 * n + 4 - row + col + 1]--;

            diff[4 * n + 4 + row]++;
            diff[4 * n + 4 + row + 1]--;

            diff[5 * n + 4 + col]++;
            diff[5 * n + 4 + col + 1]--;

            diff[6 * n + 4 + row - col + n -1]++;
            diff[6 * n + 4 + row - col + n]++;
        }

        long[] rows = new long[n];
        long[] cols = new long[n];
        long[] diag1 = new long[2 * n - 1];
        long[] diag2 = new long[2 * n - 1];

        long[] rowColSum = new long[2 * n - 1];
        long[] rowColDiff = new long[2 * n - 1];

        long[] rowSum = new long[n];
        long[] colSum = new long[n];

        long[] sum = new long[7 * n + 4];
        for (int i = 1; i < 7 * n + 4; i++) {
            diff[i] += diff[i - 1];
            sum[i] = diff[i];
        }

        int[][] res = new int[queries.length][1];
        for (int i = 0; i < queries.length; i++) {
            int row = queries[i][0], col = queries[i][1];
            int hash = row * n + col;
            if (sum[col - row + 1] > 0 || sum[row + col + n + 2] > 0 || sum[2 * n + 4 + row + col] > 0 || sum[3 * n + 4 - row + col] > 0 || sum[4 * n + 4 + row] > 0 || sum[5 * n + 4 + col] > 0 || sum[6 * n + 4 + row - col + n - 1] > 0) {
                res[i][0] = 1;
            } else {
                res[i][0] = 0;
            }

            for (int dr = -1; dr <= 1; dr++) {
                for (int dc = -1; dc <= 1; dc++) {
                    int nr = row + dr, nc = col + dc;
                    if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                        int nhash = nr * n + nc;
                        if (map.containsKey(nhash)) {
                            map.remove(nhash);
                            diff = new long[n + 2];
                            HashMap<Integer, Integer> newMap = new HashMap<>();
                            for (int[] lamp : lamps) {
                                int r = lamp[0], c = lamp[1];
                                int h = r * n + c;
                                if (map.containsKey(h) || h == nhash) continue;
                                newMap.put(h, 1);
                                int left = Math.max(0, c - r);
                                int right = Math.min(n - 1, n - 1 + c - r);
                                diff[left + 1]++;
                                diff[right + 2]--;

                                left = Math.max(0, r + c - n + 1);
                                right = Math.min(n - 1, r + c);
                                diff[n + 2 + left]++;
                                diff[n + 2 + right + 1]--;

                                diff[2 * n + 4 + r + c]++;
                                diff[2 * n + 4 + r + c + 1]--;

                                diff[3 * n + 4 - r + c]++;
                                diff[3 * n + 4 - r + c + 1]--;

                                diff[4 * n + 4 + r]++;
                                diff[4 * n + 4 + r + 1]--;

                                diff[5 * n + 4 + c]++;
                                diff[5 * n + 4 + c + 1]--;

                                diff[6 * n + 4 + r - c + n -1]++;
                                diff[6 * n + 4 + r - c + n]++;
                            }
                            lamps = new int[newMap.size()][2];
                            int k = 0;
                            for(Integer h : newMap.keySet()){
                                lamps[k][0] = h / n;
                                lamps[k][1] = h % n;
                                k++;
                            }

                            sum = new long[7 * n + 4];
                            for (int l = 1; l < 7 * n + 4; l++) {
                                diff[l] += diff[l - 1];
                                sum[l] = diff[l];
                            }
                            break;
                        }
                    }
                }
                if(lamps.length < map.size()) break;
            }

        }

        return res;
    }
}