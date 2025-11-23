class Solution {
    public String shiftingLetters(String s, int[][] shifts) {
        int n = s.length();
        int[] netShifts = new int[n + 1];

        for (int[] shift : shifts) {
            int start = shift[0];
            int end = shift[1];
            int direction = shift[2];

            if (direction == 1) { // Forward shift
                netShifts[start]++;
                if (end + 1 < n + 1) {
                    netShifts[end + 1]--;
                }
            } else { // Backward shift
                netShifts[start]--;
                if (end + 1 < n + 1) {
                    netShifts[end + 1]++;
                }
            }
        }

        char[] result = s.toCharArray();
        int currentShift = 0;
        for (int i = 0; i < n; i++) {
            currentShift += netShifts[i];

            // Calculate the new character
            // (current char - 'a' + total shift) % 26
            // Add 26 before modulo to handle negative results correctly
            int originalPos = result[i] - 'a';
            int newPos = (originalPos + currentShift) % 26;
            if (newPos < 0) {
                newPos += 26;
            }
            result[i] = (char) ('a' + newPos);
        }

        return new String(result);
    }
}