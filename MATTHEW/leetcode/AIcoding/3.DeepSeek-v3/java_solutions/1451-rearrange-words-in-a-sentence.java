class Solution {
    public String arrangeWords(String text) {
        String[] words = text.toLowerCase().split(" ");
        Arrays.sort(words, (a, b) -> a.length() - b.length());
        if (words.length == 0) return "";
        words[0] = words[0].substring(0, 1).toUpperCase() + words[0].substring(1);
        return String.join(" ", words);
    }
}