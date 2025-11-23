class Solution {
    public boolean flowerGame(int n, int m) {
        long a = n, b = m;
        return (a * b) % 2 != 0;
    }
}