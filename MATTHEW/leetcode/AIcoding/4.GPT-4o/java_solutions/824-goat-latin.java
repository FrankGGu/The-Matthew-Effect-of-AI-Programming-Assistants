class Solution {
    public String toGoatLatin(String S) {
        StringBuilder result = new StringBuilder();
        String[] words = S.split(" ");
        StringBuilder aSuffix = new StringBuilder("a");

        for (String word : words) {
            if (isVowel(word.charAt(0))) {
                result.append(word).append("ma").append(aSuffix).append(" ");
            } else {
                result.append(word.substring(1)).append(word.charAt(0)).append("ma").append(aSuffix).append(" ");
            }
            aSuffix.append("a");
        }

        return result.toString().trim();
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' || 
               c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U';
    }
}