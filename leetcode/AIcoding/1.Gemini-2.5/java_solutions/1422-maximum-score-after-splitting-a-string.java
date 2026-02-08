class Solution {
    public int maxScore(String s) {
        int n = s.length();
        int zerosLeft = 0;
        int onesRight = 0;

        // Calculate initial ones in the entire string (which will be the initial onesRight)
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == '1') {
                onesRight++;
            }
        }

        int maxScore = 0;

        // Iterate through all possible split points
        // The split point 'i' means s[0...i] is the left part and s[i+1...n-1] is the right part.
        // The left part must be non-empty, so i starts at 0.
        // The right part must be non-empty, so i can go up to n-2.
        for (int i = 0; i < n - 1; i++) {
            if (s.charAt(i) == '0') {
                zerosLeft++;
            } else { // s.charAt(i) == '1'
                onesRight--;
            }
            maxScore = Math.max(maxScore, zerosLeft + onesRight);
        }

        return maxScore;
    }
}