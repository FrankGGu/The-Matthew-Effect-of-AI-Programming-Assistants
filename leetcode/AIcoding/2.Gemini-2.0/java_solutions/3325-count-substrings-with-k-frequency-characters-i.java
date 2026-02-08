class Solution {
    public int countSubstrings(String s, int k) {
        int n = s.length();
        int count = 0;

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                String sub = s.substring(i, j + 1);
                int[] freq = new int[26];
                for (char c : sub.toCharArray()) {
                    freq[c - 'a']++;
                }

                int kCount = 0;
                for (int f : freq) {
                    if (f == k) {
                        kCount++;
                    }
                }

                if (kCount > 0) {
                    count++;
                }
            }
        }

        return count;
    }
}