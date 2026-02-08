class Solution {
    public String capitalizeTitle(String title) {
        String[] words = title.split(" ");
        StringBuilder result = new StringBuilder();

        for (int i = 0; i < words.length; i++) {
            String word = words[i].toLowerCase();
            if (word.length() > 2) {
                word = word.substring(0, 1).toUpperCase() + word.substring(1);
            }
            result.append(word);
            if (i < words.length - 1) {
                result.append(" ");
            }
        }

        return result.toString();
    }
}