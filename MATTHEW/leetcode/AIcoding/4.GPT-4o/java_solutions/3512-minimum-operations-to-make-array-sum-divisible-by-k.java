class Solution {
    public int minOperations(int[] A, int K) {
        int sum = 0;
        for (int num : A) {
            sum += num;
        }
        int remainder = sum % K;
        if (remainder == 0) return 0;

        int minOps = Integer.MAX_VALUE;
        for (int num : A) {
            int needed = (num % K + K) % K;
            if (needed == remainder) {
                minOps = Math.min(minOps, 1);
            }
            int complement = (K - needed) % K;
            if (complement == remainder) {
                minOps = Math.min(minOps, 1);
            }
        }
        return minOps == Integer.MAX_VALUE ? -1 : minOps;
    }
}