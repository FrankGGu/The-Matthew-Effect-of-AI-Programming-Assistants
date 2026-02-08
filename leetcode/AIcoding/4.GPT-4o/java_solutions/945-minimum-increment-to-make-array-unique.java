class Solution {
    public int minIncrementForUnique(int[] A) {
        Arrays.sort(A);
        int moves = 0, expected = 0;
        for (int num : A) {
            if (num < expected) {
                moves += expected - num;
            }
            expected = Math.max(expected, num) + 1;
        }
        return moves;
    }
}