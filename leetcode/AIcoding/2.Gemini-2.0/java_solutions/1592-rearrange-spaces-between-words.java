class Solution {
    public String reorderSpaces(String text = "  this   is  a sentence "){
        int spaceCount = 0;
        String[] words = text.trim().split("\\s+");
        for (char c : text.toCharArray()) {
            if (c == ' ') {
                spaceCount++;
            }
        }

        if (words.length == 1) {
            return words[0] + " ".repeat(spaceCount);
        }

        int spacesBetween = spaceCount / (words.length - 1);
        int trailingSpaces = spaceCount % (words.length - 1);

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < words.length; i++) {
            sb.append(words[i]);
            if (i < words.length - 1) {
                sb.append(" ".repeat(spacesBetween));
            }
        }

        sb.append(" ".repeat(trailingSpaces));

        return sb.toString();
    }
}