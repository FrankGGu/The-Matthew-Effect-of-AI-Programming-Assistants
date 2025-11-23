class Solution {
    public int maximumGroups(int[] grades) {
        int n = grades.length;
        int k = 0;
        while (n >= k + 1) {
            k++;
            n -= k;
        }
        return k;
    }
}