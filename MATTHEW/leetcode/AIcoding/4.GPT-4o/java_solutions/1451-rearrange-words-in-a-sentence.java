class Solution {
    public String arrangeWords(String text) {
        String[] words = text.split(" ");
        Arrays.sort(words, Comparator.comparingInt(String::length));
        StringBuilder result = new StringBuilder();
        for (String word : words) {
            result.append(word).append(" ");
        }
        result.setCharAt(0, Character.toLowerCase(result.charAt(0)));
        result.setLength(result.length() - 1);
        return Character.toUpperCase(result.charAt(0)) + result.substring(1);
    }
}