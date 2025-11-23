class Solution {
    public int minPartitions(String n) {
        char maxDigit = '0';
        for (char c : n.toCharArray()) {
            if (c > maxDigit) {
                maxDigit = c;
            }
        }
        return maxDigit - '0';
    }
}