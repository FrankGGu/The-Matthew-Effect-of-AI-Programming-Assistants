class Solution {
    public int numFriendRequests(int[] ages) {
        int[] count = new int[121];
        for (int age : ages) {
            count[age]++;
        }

        int[] prefixSum = new int[121];
        for (int i = 1; i <= 120; i++) {
            prefixSum[i] = prefixSum[i - 1] + count[i];
        }

        int res = 0;
        for (int i = 15; i <= 120; i++) {
            if (count[i] == 0) continue;
            int lower = i / 2 + 7;
            int num = prefixSum[i] - prefixSum[lower] - 1;
            res += num * count[i];
        }
        return res;
    }
}