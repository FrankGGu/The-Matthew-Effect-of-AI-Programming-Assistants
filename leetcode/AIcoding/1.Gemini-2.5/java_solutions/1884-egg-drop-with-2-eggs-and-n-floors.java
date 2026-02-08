class Solution {
    public int twoEggDrop(int n) {
        int moves = 0;
        int floorsCovered = 0;

        while (floorsCovered < n) {
            moves++;
            floorsCovered += moves;
        }

        return moves;
    }
}