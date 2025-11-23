public class Solution {
    public String decrypt(String s, int[] key) {
        StringBuilder result = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            int shift = key[i % key.length];
            char decryptedChar = (char) ((c - 'a' - shift + 26) % 26 + 'a');
            result.append(decryptedChar);
        }
        return result.toString();
    }
}