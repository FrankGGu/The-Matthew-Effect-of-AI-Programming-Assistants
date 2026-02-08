class Solution {
    public int numberOfUniqueGoodSubsequences(String binary) {
        int endWithZero = 0;
        int endWithOne = 0;
        int mod = 1000000007;
        for (char c : binary.toCharArray()) {
            if (c == '0') {
                endWithZero = (endWithOne + endWithZero) % mod;
            } else {
                endWithOne = (endWithOne + endWithZero + 1) % mod;
            }
        }
        boolean containsZero = false;
        for (char c : binary.toCharArray()) {
            if (c == '0') {
                containsZero = true;
                break;
            }
        }
        if (containsZero) {
            return (endWithOne + endWithZero + 1) % mod;
        } else {
            return (endWithOne + endWithZero) % mod;
        }
    }
}