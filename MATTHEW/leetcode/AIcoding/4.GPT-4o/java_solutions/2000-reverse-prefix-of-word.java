class Solution {
    public String reversePrefix(String word, char ch) {
        int index = word.indexOf(ch);
        if (index == -1) return word;
        StringBuilder reversed = new StringBuilder(word.substring(0, index + 1)).reverse();
        return reversed.toString() + word.substring(index + 1);
    }
}