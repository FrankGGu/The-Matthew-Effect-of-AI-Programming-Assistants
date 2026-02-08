class Solution {
    public int calculateScore(int[] nums, int[][] instructions) {
        int score = 0;
        for (int[] instr : instructions) {
            int operation = instr[0];
            int x = instr[1];
            int y = instr[2];
            if (operation == 0) {
                nums[x] = y;
            } else if (operation == 1) {
                int sum = 0;
                for (int i = x; i <= y; i++) {
                    sum += nums[i];
                }
                score += sum;
            } else if (operation == 2) {
                int product = 1;
                for (int i = x; i <= y; i++) {
                    product *= nums[i];
                }
                score += product;
            }
        }
        return score;
    }
}