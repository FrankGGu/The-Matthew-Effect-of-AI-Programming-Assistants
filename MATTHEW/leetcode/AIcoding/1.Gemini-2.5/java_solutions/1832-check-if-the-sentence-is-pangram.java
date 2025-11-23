class Solution {
    public boolean checkIfPangram(String sentence) {
        boolean[] seen = new boolean[26];
        int distinctCount = 0;

        for (char c : sentence.toCharArray()) {
            int index = c - 'a';
            if (!seen[index]) {
                seen[index] = true;
                distinctCount++;
            }
        }

        return distinctCount == 26;
    }
}