class Solution {
    public String minLexicographicalString(String s) {
        String smallestString = s;
        char[] charArray = s.toCharArray();

        for (int i = 0; i < charArray.length; i++) {
            for (int j = i + 1; j < charArray.length; j++) {
                // Swap characters
                char temp = charArray[i];
                charArray[i] = charArray[j];
                charArray[j] = temp;

                // Create a new string from the swapped array
                String currentString = new String(charArray);

                // Compare and update if smaller
                if (currentString.compareTo(smallestString) < 0) {
                    smallestString = currentString;
                }

                // Swap back to restore original state for the next iteration
                temp = charArray[i];
                charArray[i] = charArray[j];
                charArray[j] = temp;
            }
        }

        return smallestString;
    }
}