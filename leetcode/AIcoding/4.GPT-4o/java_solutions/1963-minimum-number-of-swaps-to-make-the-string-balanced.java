class Solution {
    public int minSwaps(String s) {
        int balance = 0, maxBalance = 0;
        for (char c : s.toCharArray()) {
            balance += c == '[' ? 1 : -1;
            maxBalance = Math.min(maxBalance, balance);
        }
        return (balance + (-maxBalance)) / 2;
    }
}