class Solution {
    public int countDivisibleSubstrings(String s) {
        int n = s.length();
        int count = 0;

        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '0') continue;
            int num = 0;
            for (int j = i; j < n; j++) {
                num = num * 10 + (s.charAt(j) - '0');
                if (num % (s.charAt(n - 1) - '0') == 0) {
                    count++;
                }
            }
        }
        return count;
    }
}