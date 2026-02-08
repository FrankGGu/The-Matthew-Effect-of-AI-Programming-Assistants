class Solution {
    public int maxPartitionAfterOperations(String s, int k) {
        int n = s.length();
        if (k >= 26) {
            return 1;
        }
        int count = 1;
        int mask = 0;
        for (int i = 0; i < n; i++) {
            int c = s.charAt(i) - 'a';
            if ((mask & (1 << c)) == 0) {
                if (Integer.bitCount(mask) == k) {
                    count++;
                    mask = 0;
                }
                mask |= (1 << c);
            }
        }
        return count;
    }
}