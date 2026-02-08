class Solution {
    public int numSub(String s) {
        long count = 0, result = 0;
        for (char c : s.toCharArray()) {
            if (c == '1') {
                count++;
                result = (result + count) % 1000000007;
            } else {
                count = 0;
            }
        }
        return (int) result;
    }
}