class Solution {
    public int maximumGroups(int[] grades) {
        int n = grades.length;
        int k = 0;
        while ((k + 1) * (k + 2) / 2 <= n) {
            k++;
        }
        return k;
    }
}