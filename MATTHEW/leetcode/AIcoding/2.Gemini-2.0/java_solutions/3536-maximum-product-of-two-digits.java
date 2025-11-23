class Solution {
    public int maxProduct(String s) {
        int n = s.length();
        int maxProd = 0;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int prod = (s.charAt(i) - '0') * (s.charAt(j) - '0');
                maxProd = Math.max(maxProd, prod);
            }
        }
        return maxProd;
    }
}