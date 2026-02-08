class Solution {
    public int sumOfEncryptedIntegers(String s) {
        int sum = 0;
        for (String num : s.split(",")) {
            sum += Integer.parseInt(num.trim());
        }
        return sum;
    }
}