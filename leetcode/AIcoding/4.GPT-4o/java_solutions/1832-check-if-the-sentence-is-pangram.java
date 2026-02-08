class Solution {
    public boolean checkIfPangram(String sentence) {
        boolean[] alphabet = new boolean[26];
        int index = 0;
        for (char c : sentence.toCharArray()) {
            index = c - 'a';
            alphabet[index] = true;
        }
        for (boolean b : alphabet) {
            if (!b) return false;
        }
        return true;
    }
}