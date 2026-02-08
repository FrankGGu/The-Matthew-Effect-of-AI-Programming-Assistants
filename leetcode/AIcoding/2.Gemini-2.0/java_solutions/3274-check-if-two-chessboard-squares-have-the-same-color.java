class Solution {
    public boolean squareIsWhite(String coordinates) {
        char file = coordinates.charAt(0);
        char rank = coordinates.charAt(1);

        int fileNum = file - 'a' + 1;
        int rankNum = rank - '0';

        return (fileNum % 2) != (rankNum % 2);
    }
}