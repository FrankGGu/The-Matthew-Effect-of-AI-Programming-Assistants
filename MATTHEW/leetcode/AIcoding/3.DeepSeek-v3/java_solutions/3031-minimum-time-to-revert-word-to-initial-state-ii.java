class Solution {
    public int minimumTimeToInitialState(String word, int k) {
        int n = word.length();
        for (int t = 1; t * k < n; t++) {
            boolean match = true;
            for (int i = t * k; i < n; i++) {
                if (word.charAt(i) != word.charAt(i - t * k)) {
                    match = false;
                    break;
                }
            }
            if (match) {
                return t;
            }
        }
        return (n + k - 1) / k;
    }
}