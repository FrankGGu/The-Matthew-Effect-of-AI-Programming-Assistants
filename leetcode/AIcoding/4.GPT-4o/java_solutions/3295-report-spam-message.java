class Solution {
    public int reportSpam(String[] messages) {
        int spamCount = 0;
        for (String message : messages) {
            if (message.contains("spam")) {
                spamCount++;
            }
        }
        return spamCount;
    }
}