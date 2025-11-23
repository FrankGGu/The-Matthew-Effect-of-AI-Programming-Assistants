class Solution {
    public int balancedStringSplit(String s) {
        int balance = 0, count = 0;
        for (char c : s.toCharArray()) {
            balance += (c == 'L') ? 1 : -1;
            if (balance == 0) {
                count++;
            }
        }
        return count;
    }
}