class Solution {
    public int maxProduct(String s) {
        int n = s.length();
        List<Integer> palindromicLengths = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                if (isPalindrome(s, i, j)) {
                    palindromicLengths.add(j - i + 1);
                }
            }
        }

        int maxProduct = 0;
        int m = palindromicLengths.size();

        for (int i = 0; i < m; i++) {
            for (int j = i + 1; j < m; j++) {
                if (checkDisjoint(palindromicLengths.get(i), palindromicLengths.get(j), s)) {
                    maxProduct = Math.max(maxProduct, palindromicLengths.get(i) * palindromicLengths.get(j));
                }
            }
        }

        return maxProduct;
    }

    private boolean isPalindrome(String s, int left, int right) {
        while (left < right) {
            if (s.charAt(left++) != s.charAt(right--)) {
                return false;
            }
        }
        return true;
    }

    private boolean checkDisjoint(int len1, int len2, String s) {
        // Add logic to check if two palindromic substrings are disjoint
        return true; // Placeholder, you need to implement actual logic
    }
}