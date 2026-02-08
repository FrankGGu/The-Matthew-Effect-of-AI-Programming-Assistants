class Solution {
    public int minSwaps(String s) {
        int n = s.length();
        int count0 = 0;
        int count1 = 0;

        for (char c : s.toCharArray()) {
            if (c == '0') {
                count0++;
            } else {
                count1++;
            }
        }

        if (Math.abs(count0 - count1) > 1) {
            return -1;
        }

        int minSwaps = Integer.MAX_VALUE;

        // Case 1: Target string starts with '0' (e.g., "010101...")
        // This is possible if count0 is equal to count1 or count0 is one more than count1
        if (count0 >= count1) {
            int mismatches = 0;
            char expectedChar = '0';
            for (int i = 0; i < n; i++) {
                if (s.charAt(i) != expectedChar) {
                    mismatches++;
                }
                expectedChar = (expectedChar == '0' ? '1' : '0');
            }
            minSwaps = Math.min(minSwaps, mismatches / 2);
        }

        // Case 2: Target string starts with '1' (e.g., "101010...")
        // This is possible if count1 is equal to count0 or count1 is one more than count0
        if (count1 >= count0) {
            int mismatches = 0;
            char expectedChar = '1';
            for (int i = 0; i < n; i++) {
                if (s.charAt(i) != expectedChar) {
                    mismatches++;
                }
                expectedChar = (expectedChar == '0' ? '1' : '0');
            }
            minSwaps = Math.min(minSwaps, mismatches / 2);
        }

        return minSwaps;
    }
}