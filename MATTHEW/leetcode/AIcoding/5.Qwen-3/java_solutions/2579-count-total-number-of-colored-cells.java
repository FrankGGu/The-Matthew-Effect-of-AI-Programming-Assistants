public class Solution {
    public int countColoredCells(int p) {
        return (int) Math.pow(p, 2) + (int) Math.pow(p - 1, 2);
    }
}