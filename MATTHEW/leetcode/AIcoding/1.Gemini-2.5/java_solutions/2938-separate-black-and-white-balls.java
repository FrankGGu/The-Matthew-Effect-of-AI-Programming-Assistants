class Solution {
    public long minimumSteps(String s) {
        long swaps = 0;
        int zeroCount = 0;

        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '0') {
                swaps += (i - zeroCount);
                zeroCount++;
            }
        }

        return swaps;
    }
}