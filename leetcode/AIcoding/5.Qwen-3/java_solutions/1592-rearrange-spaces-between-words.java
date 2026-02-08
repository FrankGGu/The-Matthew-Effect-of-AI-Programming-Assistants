public class Solution {

class Solution {
    public String reorderSpaces(String text) {
        String[] words = text.split("\\s+");
        int totalWords = words.length;
        int totalSpaces = text.length() - text.replace(" ", "").length();

        if (totalWords == 1) {
            return words[0] + " ".repeat(totalSpaces);
        }

        int spacesBetween = totalSpaces / (totalWords - 1);
        int extraSpaces = totalSpaces % (totalWords - 1);

        StringBuilder result = new StringBuilder();
        for (int i = 0; i < totalWords; i++) {
            result.append(words[i]);
            if (i < totalWords - 1) {
                result.append(" ".repeat(spacesBetween));
                if (extraSpaces > 0) {
                    result.append(" ");
                    extraSpaces--;
                }
            }
        }

        return result.toString();
    }
}
}