class Solution {
    public int countDivisibleSubstrings(String word) {
        int count = 0;
        int n = word.length();
        for (int i = 0; i < n; i++) {
            int sum = 0;
            for (int j = i; j < n; j++) {
                char c = word.charAt(j);
                sum += (c - 'a' + 1);
                int len = j - i + 1;
                if (sum % len == 0) {
                    count++;
                }
            }
        }
        return count;
    }
}