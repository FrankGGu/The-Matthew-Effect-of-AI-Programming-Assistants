class Solution {
    public int maximumReward(int[] rewards, int k) {
        Arrays.sort(rewards);
        int n = rewards.length;
        int totalReward = 0;
        for (int i = n - 1; i >= n - k; i--) {
            totalReward += rewards[i];
        }
        return totalReward;
    }
}