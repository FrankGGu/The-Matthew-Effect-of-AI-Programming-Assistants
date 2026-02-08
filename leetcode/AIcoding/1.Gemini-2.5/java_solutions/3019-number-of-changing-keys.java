class Solution {
    public int countKeyChanges(String s) {
        int count = 0;
        char prevChar = Character.toLowerCase(s.charAt(0));

        for (int i = 1; i < s.length(); i++) {
            char currentChar = Character.toLowerCase(s.charAt(i));
            if (currentChar != prevChar) {
                count++;
            }
            prevChar = currentChar;
        }

        return count;
    }
}