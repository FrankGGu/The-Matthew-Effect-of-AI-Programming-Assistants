public class Solution {
    public String robotWithString(String s) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            count[c - 'a']++;
        }

        StringBuilder result = new StringBuilder();
        StringBuilder stack = new StringBuilder();

        for (char c : s.toCharArray()) {
            stack.append(c);
            count[c - 'a']--;

            while (stack.length() > 0 && (result.length() == 0 || stack.charAt(stack.length() - 1) <= getMin(count))) {
                result.append(stack.charAt(stack.length() - 1));
                stack.deleteCharAt(stack.length() - 1);
            }
        }

        return result.toString();
    }

    private char getMin(int[] count) {
        for (int i = 0; i < 26; i++) {
            if (count[i] > 0) {
                return (char) (i + 'a');
            }
        }
        return ' ';
    }
}