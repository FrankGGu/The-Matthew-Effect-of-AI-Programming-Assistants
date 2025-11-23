class Solution {
    public String reverseWords(String s) {
        String[] words = s.split(" ");
        StringBuilder reversed = new StringBuilder();
        for (String word : words) {
            if (reversed.length() > 0) {
                reversed.append(" ");
            }
            reversed.append(new StringBuilder(word).reverse().toString());
        }
        return reversed.toString();
    }
}