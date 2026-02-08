class Solution {
    public int minimumTimeToInitialState(String word, int k) {
        int n = word.length();
        int count = 0;
        for (int i = k; i < n; i += k) {
            if (word.substring(i).equals(word.substring(0, n - i))) {
                return count + 1;
            }
            count++;
        }
        return count + 1;
    }
}