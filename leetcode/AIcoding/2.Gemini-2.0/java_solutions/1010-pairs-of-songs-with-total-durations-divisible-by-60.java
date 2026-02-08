class Solution {
    public int numPairsDivisibleBy60(int[] time) {
        int[] count = new int[60];
        int ans = 0;
        for (int t : time) {
            int rem = t % 60;
            ans += count[(60 - rem) % 60];
            count[rem]++;
        }
        return ans;
    }
}