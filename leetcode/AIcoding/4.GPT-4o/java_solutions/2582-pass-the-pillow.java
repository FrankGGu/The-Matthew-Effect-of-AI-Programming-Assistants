class Solution {
    public int passThePillow(int n, int time) {
        int position = time % (2 * (n - 1));
        return position < n ? position + 1 : 2 * n - position - 1;
    }
}