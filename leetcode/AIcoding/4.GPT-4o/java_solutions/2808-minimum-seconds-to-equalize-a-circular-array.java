class Solution {
    public int minimumSeconds(List<Integer> nums) {
        int n = nums.size();
        int[] next = new int[n];
        int[] last = new int[100001];
        Arrays.fill(last, -1);
        for (int i = 0; i < n; i++) {
            last[nums.get(i)] = i;
        }
        for (int i = 0; i < n; i++) {
            next[i] = n;
            if (last[nums.get(i)] != -1) {
                next[i] = last[nums.get(i)];
                last[nums.get(i)] = i;
            }
        }
        int ans = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            int count = 0;
            int j = i;
            while (count < n) {
                j = next[j];
                count++;
            }
            ans = Math.min(ans, count);
        }
        return ans;
    }
}