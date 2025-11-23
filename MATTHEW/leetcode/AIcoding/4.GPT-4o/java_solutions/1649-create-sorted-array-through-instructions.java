class Solution {
    public int createSortedArray(int[] instructions) {
        int MOD = 1000000007;
        int max = 0;
        for (int num : instructions) {
            max = Math.max(max, num);
        }
        int[] count = new int[max + 1];
        long res = 0;

        for (int num : instructions) {
            int left = 0, right = num;
            for (int i = 0; i < num; i++) {
                left += count[i];
            }
            for (int i = num + 1; i <= max; i++) {
                right += count[i];
            }
            res = (res + Math.min(left, right)) % MOD;
            count[num]++;
        }
        return (int) res;
    }
}