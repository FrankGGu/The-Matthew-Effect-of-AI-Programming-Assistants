class Solution {
    public int minAnagramLength(String s) {
        int n = s.length();
        for (int k = 1; k <= n; k++) {
            if (n % k != 0) continue;
            boolean valid = true;
            String first = s.substring(0, k);
            int[] count = new int[26];
            for (char c : first.toCharArray()) {
                count[c - 'a']++;
            }
            for (int i = k; i < n; i += k) {
                String current = s.substring(i, i + k);
                int[] currentCount = new int[26];
                for (char c : current.toCharArray()) {
                    currentCount[c - 'a']++;
                }
                if (!Arrays.equals(count, currentCount)) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                return k;
            }
        }
        return n;
    }
}