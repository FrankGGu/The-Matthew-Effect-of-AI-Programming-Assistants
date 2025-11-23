class Solution {
    private int res = Integer.MAX_VALUE;

    public int minimumTimeRequired(int[] jobs, int k) {
        int[] workers = new int[k];
        backtrack(jobs, workers, 0, 0);
        return res;
    }

    private void backtrack(int[] jobs, int[] workers, int idx, int max) {
        if (idx == jobs.length) {
            res = Math.min(res, max);
            return;
        }
        Set<Integer> seen = new HashSet<>();
        for (int i = 0; i < workers.length; i++) {
            if (seen.contains(workers[i])) continue;
            if (workers[i] + jobs[idx] >= res) continue;
            seen.add(workers[i]);
            workers[i] += jobs[idx];
            backtrack(jobs, workers, idx + 1, Math.max(max, workers[i]));
            workers[i] -= jobs[idx];
        }
    }
}