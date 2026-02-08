class Solution {
    public int beautifulSubstrings(String s) {
        int count = 0;
        int n = s.length();
        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                String substring = s.substring(i, j + 1);
                if (isBeautiful(substring)) {
                    count++;
                }
            }
        }
        return count;
    }

    private boolean isBeautiful(String substring) {
        int[] freq = new int[26];
        for (char c : substring.toCharArray()) {
            freq[c - 'a']++;
        }
        int oddCount = 0;
        for (int f : freq) {
            if (f % 2 != 0) {
                oddCount++;
            }
        }
        return oddCount <= 1;
    }
}