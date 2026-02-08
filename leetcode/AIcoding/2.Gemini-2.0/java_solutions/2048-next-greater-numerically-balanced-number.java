class Solution {
    public int nextBeautifulNumber(int n) {
        n++;
        while (true) {
            String s = String.valueOf(n);
            int[] counts = new int[10];
            for (char c : s.toCharArray()) {
                counts[c - '0']++;
            }
            boolean balanced = true;
            for (int i = 0; i < 10; i++) {
                if (counts[i] != 0 && counts[i] != i) {
                    balanced = false;
                    break;
                }
            }
            if (balanced) {
                return n;
            }
            n++;
        }
    }
}