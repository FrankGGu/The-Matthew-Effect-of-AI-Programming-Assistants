class Solution {
    public int minimumOperations(int num) {
        int operations = 0;
        while (num > 0) {
            operations++;
            int minDigit = 9;
            for (char c : String.valueOf(num).toCharArray()) {
                minDigit = Math.min(minDigit, c - '0');
            }
            num -= minDigit;
        }
        return operations;
    }
}