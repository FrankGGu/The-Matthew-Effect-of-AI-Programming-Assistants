class Solution {
    public int minimumTimeToInitialState(String word, int k) {
        int n = word.length();
        int count = 0;
        for (int i = k; i < n; i += k) {
            boolean match = true;
            for (int j = 0; j < n - i; j++) {
                if (word.charAt(j) != word.charAt(i + j)) {
                    match = false;
                    break;
                }
            }
            if (match) {
                return count + 1;
            }
            count++;
        }
        return count + 1;
    }
}