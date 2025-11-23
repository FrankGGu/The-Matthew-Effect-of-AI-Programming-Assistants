public class Solution {
    public int partitionString(String s, int k) {
        int count = 1;
        int current = 0;
        for (char c : s.toCharArray()) {
            int val = c - 'a' + 1;
            if (val > k) {
                return -1;
            }
            if (current * 10 + val > k) {
                count++;
                current = val;
            } else {
                current = current * 10 + val;
            }
        }
        return count;
    }
}