class Solution {
    public int minimumCost(String s) {
        int n = s.length();
        int cost = 0;

        for (int i = 0; i < n / 2; i++) {
            if (s.charAt(i) != s.charAt(n - 1 - i)) {
                cost += Math.min(s.charAt(i) - 'a' + 1, s.charAt(n - 1 - i) - 'a' + 1);
            }
        }

        return cost;
    }
}