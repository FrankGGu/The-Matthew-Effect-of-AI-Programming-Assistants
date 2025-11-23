class Solution {
    public int chalkReplacer(int[] chalk, int k) {
        long sumChalk = 0;
        for (int c : chalk) {
            sumChalk += c;
        }

        long remainingK = k % sumChalk;

        for (int i = 0; i < chalk.length; i++) {
            if (remainingK < chalk[i]) {
                return i;
            }
            remainingK -= chalk[i];
        }

        return -1; // Should not be reached based on problem description
    }
}