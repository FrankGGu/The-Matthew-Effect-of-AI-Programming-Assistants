class Solution {
    public boolean squareIsWhite(String coordinates) {
        int col = coordinates.charAt(0) - 'a';
        int row = coordinates.charAt(1) - '1';

        // If (col + row) is even, the square is black (like 'a1' -> 0+0=0, even)
        // If (col + row) is odd, the square is white (like 'a2' -> 0+1=1, odd)
        // We want to return true if the square is white.
        return (col + row) % 2 != 0;
    }
}