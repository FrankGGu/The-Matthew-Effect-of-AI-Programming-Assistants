public class Solution {
    public String sortVowels(String s) {
        char[] chars = s.toCharArray();
        int n = chars.length;
        StringBuilder vowels = new StringBuilder();

        for (int i = 0; i < n; i++) {
            char c = chars[i];
            if (isVowel(c)) {
                vowels.append(c);
                chars[i] = ' ';
            }
        }

        vowels.sort(null);

        int vowelIndex = 0;
        for (int i = 0; i < n; i++) {
            if (chars[i] == ' ') {
                chars[i] = vowels.charAt(vowelIndex++);
            }
        }

        return new String(chars);
    }

    private boolean isVowel(char c) {
        return "aeiouAEIOU".indexOf(c) != -1;
    }
}