public class Solution {
    public int minMovesToSeatEveryone(int[] seats, int[] students) {
        java.util.Arrays.sort(seats);
        java.util.Arrays.sort(students);
        int moves = 0;
        for (int i = 0; i < seats.length; i++) {
            moves += Math.abs(seats[i] - students[i]);
        }
        return moves;
    }
}