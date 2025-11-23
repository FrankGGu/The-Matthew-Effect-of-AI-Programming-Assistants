class Solution {
    public String reorderSpaces(String text) {
        int spaceCount = 0;
        for (char c : text.toCharArray()) {
            if (c == ' ') {
                spaceCount++;
            }
        }

        String[] words = text.trim().split("\\s+");
        int wordCount = words.length;

        if (wordCount == 1) {
            return words[0] + " ".repeat(spaceCount);
        }

        int gap = spaceCount / (wordCount - 1);
        int trailing = spaceCount % (wordCount - 1);

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < words.length; i++) {
            sb.append(words[i]);
            if (i < words.length - 1) {
                sb.append(" ".repeat(gap));
            }
        }
        sb.append(" ".repeat(trailing));

        return sb.toString();
    }
}