class Solution {
    public int minimumBoxes(int n) {
        int level = 1;
        int total = 0;
        while (total + level * (level + 1) / 2 <= n) {
            total += level * (level + 1) / 2;
            level++;
        }
        level--;

        int res = level * (level + 1) / 2;
        int k = 1;
        while (total + k <= n) {
            total += k;
            res++;
            k++;
        }
        return res;
    }
}