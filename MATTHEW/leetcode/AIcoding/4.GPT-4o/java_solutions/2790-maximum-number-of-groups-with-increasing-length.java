class Solution {
    public int maxGroups(int[] grades) {
        int n = 0;
        while (n * (n + 1) / 2 <= grades.length) {
            n++;
        }
        return n - 1;
    }
}