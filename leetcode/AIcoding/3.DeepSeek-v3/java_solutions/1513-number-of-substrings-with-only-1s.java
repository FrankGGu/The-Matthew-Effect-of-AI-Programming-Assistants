class Solution {
    public int numSub(String s) {
        long count = 0;
        long consecutive = 0;
        int mod = 1000000007;

        for (char c : s.toCharArray()) {
            if (c == '1') {
                consecutive++;
                count += consecutive;
            } else {
                consecutive = 0;
            }
        }

        return (int)(count % mod);
    }
}