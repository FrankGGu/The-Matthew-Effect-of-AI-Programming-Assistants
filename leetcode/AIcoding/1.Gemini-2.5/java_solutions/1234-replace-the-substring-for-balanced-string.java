class Solution {
    private int charToInt(char c) {
        if (c == 'Q') return 0;
        if (c == 'W') return 1;
        if (c == 'E') return 2;
        return 3; // 'R'
    }

    public int balancedString(String s) {
        int n = s.length();
        int target = n / 4;

        int[] totalCounts = new int[4]; // 0:Q, 1:W, 2:E, 3:R
        for (char c : s.toCharArray()) {
            totalCounts[charToInt(c)]++;
        }

        int[] required = new int[4];
        boolean alreadyBalanced = true;
        for (int i = 0; i < 4; i++) {
            if (totalCounts[i] > target) {
                required[i] = totalCounts[i] - target;
                alreadyBalanced = false;
            } else {
                required[i] = 0;
            }
        }

        if (alreadyBalanced) {
            return 0;
        }

        int left = 0;
        int minLen = n;
        int[] windowCounts = new int[4];

        for (int right = 0; right < n; right++) {
            windowCounts[charToInt(s.charAt(right))]++;

            // Check if the current window is valid
            // A window is valid if it contains at least 'required[c]' of each character 'c'
            while (windowCounts[0] >= required[0] &&
                   windowCounts[1] >= required[1] &&
                   windowCounts[2] >= required[2] &&
                   windowCounts[3] >= required[3]) {

                minLen = Math.min(minLen, right - left + 1);

                // Try to shrink the window from the left
                windowCounts[charToInt(s.charAt(left))]--;
                left++;
            }
        }

        return minLen;
    }
}