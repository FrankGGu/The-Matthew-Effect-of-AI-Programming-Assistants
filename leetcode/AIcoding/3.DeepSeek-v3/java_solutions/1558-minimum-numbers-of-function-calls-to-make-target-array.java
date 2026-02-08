class Solution {
    public int minOperations(int[] nums) {
        int addOps = 0;
        int mulOps = 0;

        for (int num : nums) {
            int currentMulOps = 0;
            while (num > 0) {
                if (num % 2 == 1) {
                    addOps++;
                    num--;
                } else {
                    currentMulOps++;
                    num /= 2;
                }
            }
            mulOps = Math.max(mulOps, currentMulOps);
        }

        return addOps + mulOps;
    }
}