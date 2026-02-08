class Solution {
    public String shiftingLetters(String s, int[][] shifts) {
        int n = s.length();
        int[] diff = new int[n + 1];

        for (int[] shift : shifts) {
            int start = shift[0];
            int end = shift[1];
            int direction = shift[2];

            if (direction == 1) {
                diff[start] += 1;
                diff[end + 1] -= 1;
            } else {
                diff[start] -= 1;
                diff[end + 1] += 1;
            }
        }

        int[] prefixSum = new int[n];
        prefixSum[0] = diff[0];
        for (int i = 1; i < n; i++) {
            prefixSum[i] = prefixSum[i - 1] + diff[i];
        }

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) {
            int shiftVal = prefixSum[i] % 26;
            if (shiftVal < 0) {
                shiftVal += 26;
            }
            char originalChar = s.charAt(i);
            int newCharVal = (originalChar - 'a' + shiftVal) % 26;
            char newChar = (char) ('a' + newCharVal);
            sb.append(newChar);
        }

        return sb.toString();
    }
}