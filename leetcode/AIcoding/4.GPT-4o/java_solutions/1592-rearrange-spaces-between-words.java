class Solution {
    public String rearrangeSpaces(String text) {
        int spaceCount = 0;
        int wordCount = 0;
        StringBuilder result = new StringBuilder();
        String[] words = text.split(" ");

        for (String word : words) {
            if (!word.isEmpty()) {
                wordCount++;
                result.append(word);
            }
        }

        for (char c : text.toCharArray()) {
            if (c == ' ') spaceCount++;
        }

        if (wordCount == 1) {
            return result.append(" ".repeat(spaceCount)).toString();
        }

        int spacesBetweenWords = spaceCount / (wordCount - 1);
        int extraSpaces = spaceCount % (wordCount - 1);

        StringBuilder spaces = new StringBuilder(" ".repeat(spacesBetweenWords));

        StringBuilder finalResult = new StringBuilder();
        for (int i = 0; i < wordCount; i++) {
            finalResult.append(result.substring(0, result.indexOf(" ")));
            result.delete(0, result.indexOf(" ") + 1);
            if (i < wordCount - 1) {
                finalResult.append(spaces);
            }
        }

        return finalResult.append(" ".repeat(extraSpaces)).toString();
    }
}