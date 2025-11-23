class Solution {
    public String capitalizeTitle(String title) {
        String[] words = title.toLowerCase().split(" ");
        StringBuilder result = new StringBuilder();

        for (String word : words) {
            if (word.length() > 2) {
                result.append(Character.toUpperCase(word.charAt(0)));
            } else {
                result.append(word.charAt(0));
            }
            result.append(word.substring(1)).append(" ");
        }

        return result.toString().trim();
    }
}