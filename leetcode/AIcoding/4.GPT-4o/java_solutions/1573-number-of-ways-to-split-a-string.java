class Solution {
    public int numWays(String s) {
        int countOnes = 0;
        for (char c : s.toCharArray()) {
            if (c == '1') countOnes++;
        }
        if (countOnes == 0) return (int) ((long) (s.length() - 1) * (s.length()) / 2 % 1_000_000_007);
        if (countOnes % 3 != 0) return 0;

        int partSize = countOnes / 3;
        int firstPartCount = 0, secondPartCount = 0, thirdPartCount = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '1') {
                if (firstPartCount < partSize) {
                    firstPartCount++;
                } else if (secondPartCount < partSize) {
                    secondPartCount++;
                } else {
                    thirdPartCount++;
                }
            }
        }

        long firstPartWays = 1;
        long secondPartWays = 1;

        for (int i = s.length() - 1; i >= 0; i--) {
            if (s.charAt(i) == '1') {
                if (thirdPartCount > 0) {
                    thirdPartCount--;
                } else if (secondPartCount > 0) {
                    secondPartCount--;
                    firstPartWays++;
                } else {
                    break;
                }
            }
        }

        for (int i = s.length() - 1; i >= 0; i--) {
            if (s.charAt(i) == '1') {
                if (secondPartCount > 0) {
                    secondPartCount--;
                } else if (firstPartCount > 0) {
                    firstPartCount--;
                    secondPartWays++;
                } else {
                    break;
                }
            }
        }

        return (int) ((firstPartWays * secondPartWays) % 1_000_000_007);
    }
}