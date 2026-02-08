class Solution {
    public int[] recoverArray(int n, int[] sums) {
        Arrays.sort(sums);
        List<Integer> res = new ArrayList<>();
        dfs(sums, res);
        int[] ans = new int[res.size()];
        for (int i = 0; i < ans.length; i++) {
            ans[i] = res.get(i);
        }
        return ans;
    }

    private void dfs(int[] sums, List<Integer> res) {
        if (sums.length == 1) return;
        int n = sums.length;
        int x = sums[1] - sums[0];
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : sums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }
        List<Integer> left = new ArrayList<>();
        List<Integer> right = new ArrayList<>();
        boolean found = false;
        for (int num : sums) {
            if (freq.get(num) > 0) {
                if (freq.getOrDefault(num + x, 0) > 0) {
                    left.add(num);
                    right.add(num + x);
                    freq.put(num, freq.get(num) - 1);
                    freq.put(num + x, freq.get(num + x) - 1);
                } else {
                    found = true;
                    break;
                }
            }
        }
        if (!found) {
            res.add(x);
            int[] newSums = new int[left.size()];
            for (int i = 0; i < newSums.length; i++) {
                newSums[i] = left.get(i);
            }
            dfs(newSums, res);
        } else {
            res.add(-x);
            int[] newSums = new int[right.size()];
            for (int i = 0; i < newSums.length; i++) {
                newSums[i] = right.get(i);
            }
            dfs(newSums, res);
        }
    }
}