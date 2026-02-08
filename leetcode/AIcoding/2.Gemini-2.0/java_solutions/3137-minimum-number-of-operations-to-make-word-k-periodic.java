class Solution {
    public int minOperations(String word, int k) {
        int n = word.length();
        if (n % k != 0) {
            return -1;
        }
        int periods = n / k;
        int ans = 0;
        for (int i = 0; i < k; i++) {
            for (int j = 1; j < periods; j++) {
                if (word.charAt(i) != word.charAt(i + j * k)) {
                    ans++;
                }
            }
        }
        return ans;
    }
}