class Solution {
    public String shiftingLetters(String s, List<List<Integer>> shifts) {
        int n = s.length();
        int[] shift = new int[n + 1];
        for (List<Integer> shiftInfo : shifts) {
            int start = shiftInfo.get(0), end = shiftInfo.get(1), direction = shiftInfo.get(2);
            shift[start] += (direction == 1 ? 1 : -1);
            if (end + 1 < n) {
                shift[end + 1] -= (direction == 1 ? 1 : -1);
            }
        }

        for (int i = 1; i < n; i++) {
            shift[i] += shift[i - 1];
        }

        StringBuilder result = new StringBuilder();
        for (int i = 0; i < n; i++) {
            char newChar = (char) ((s.charAt(i) - 'a' + (shift[i] % 26) + 26) % 26 + 'a');
            result.append(newChar);
        }

        return result.toString();
    }
}