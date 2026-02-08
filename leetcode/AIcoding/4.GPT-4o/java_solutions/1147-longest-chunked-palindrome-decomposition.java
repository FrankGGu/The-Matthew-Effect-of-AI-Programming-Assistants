class Solution {
    public int longestDecomposition(String text) {
        int n = text.length();
        int count = 0;

        for (int i = 0; i < n / 2; i++) {
            if (text.substring(i, n - i).equals(text.substring(i, n - i).reverse())) {
                count++;
            }
        }

        return count * 2 + (n % 2);
    }
}