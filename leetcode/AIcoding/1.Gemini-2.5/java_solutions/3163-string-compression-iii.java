class Solution {
    public String compressedString(String word) {
        StringBuilder sb = new StringBuilder();
        int n = word.length();
        int i = 0; // Pointer for the start of the current maximal group

        while (i < n) {
            char currentChar = word.charAt(i);
            int j = i; // Pointer to find the end of the current maximal group

            // Count the total occurrences of currentChar in this maximal group
            while (j < n && word.charAt(j) == currentChar) {
                j++;
            }

            int totalCount = j - i; // Total count of currentChar in this group

            // Apply compression rules based on totalCount
            // If totalCount is 1, just append the character.
            // If totalCount is > 1, break it down into chunks of up to 9.
            if (totalCount == 1) {
                sb.append(currentChar);
            } else {
                while (totalCount > 0) {
                    sb.append(currentChar);
                    int countToAppend = Math.min(totalCount, 9);
                    sb.append(countToAppend);
                    totalCount -= countToAppend;
                }
            }

            i = j; // Move i to the start of the next maximal group
        }

        return sb.toString();
    }
}