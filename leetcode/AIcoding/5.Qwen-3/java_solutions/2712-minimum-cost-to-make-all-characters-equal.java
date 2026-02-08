public class Solution {
    public int minimumCost(String s) {
        int n = s.length();
        int cost = 0;
        for (int i = 1; i < n; i++) {
            if (s.charAt(i) != s.charAt(i - 1)) {
                cost += 1;
            }
        }
        return cost;
    }
}