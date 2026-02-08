class Solution {
    public int partitionString(String s) {
        int count = 1;
        int mask = 0;
        for (char c : s.toCharArray()) {
            int bit = 1 << (c - 'a');
            if ((mask & bit) != 0) {
                count++;
                mask = 0;
            }
            mask |= bit;
        }
        return count;
    }
}