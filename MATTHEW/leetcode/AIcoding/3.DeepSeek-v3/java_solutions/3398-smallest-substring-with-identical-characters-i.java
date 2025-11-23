class Solution {
    public String smallestSubstringWithIdenticalChars(String s) {
        if (s == null || s.length() == 0) {
            return "";
        }

        int minLength = Integer.MAX_VALUE;
        String result = "";

        for (int i = 0; i < s.length(); ) {
            char currentChar = s.charAt(i);
            int j = i;
            while (j < s.length() && s.charAt(j) == currentChar) {
                j++;
            }
            int currentLength = j - i;
            if (currentLength < minLength) {
                minLength = currentLength;
                result = s.substring(i, j);
            } else if (currentLength == minLength && s.substring(i, j).compareTo(result) < 0) {
                result = s.substring(i, j);
            }
            i = j;
        }

        return result;
    }
}