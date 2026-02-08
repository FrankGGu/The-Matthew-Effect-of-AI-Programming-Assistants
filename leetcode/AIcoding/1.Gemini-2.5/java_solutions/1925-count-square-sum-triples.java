class Solution {
    public int countTriples(int n) {
        int count = 0;
        for (int a = 1; a <= n; a++) {
            for (int b = 1; b <= n; b++) {
                int sumSq = a * a + b * b;
                int c = (int) Math.sqrt(sumSq);
                if (c * c == sumSq && c <= n) {
                    count++;
                }
            }
        }
        return count;
    }
}