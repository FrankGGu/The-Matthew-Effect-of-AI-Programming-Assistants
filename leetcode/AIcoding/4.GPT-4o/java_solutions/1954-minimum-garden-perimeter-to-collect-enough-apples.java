class Solution {
    public long minimumPerimeter(long neededApples) {
        long n = (long) Math.ceil(Math.sqrt(neededApples / 3));
        return 8 * n;
    }
}