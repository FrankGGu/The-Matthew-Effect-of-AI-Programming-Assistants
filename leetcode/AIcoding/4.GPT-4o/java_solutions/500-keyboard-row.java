import java.util.HashSet;

class Solution {
    public String[] findWords(String[] words) {
        String row1 = "qwertyuiop";
        String row2 = "asdfghjkl";
        String row3 = "zxcvbnm";

        HashSet<Character> set1 = new HashSet<>();
        HashSet<Character> set2 = new HashSet<>();
        HashSet<Character> set3 = new HashSet<>();

        for (char c : row1.toCharArray()) set1.add(c);
        for (char c : row2.toCharArray()) set2.add(c);
        for (char c : row3.toCharArray()) set3.add(c);

        List<String> result = new ArrayList<>();

        for (String word : words) {
            String lowerWord = word.toLowerCase();
            if (set1.contains(lowerWord.charAt(0))) {
                if (canForm(lowerWord, set1)) result.add(word);
            } else if (set2.contains(lowerWord.charAt(0))) {
                if (canForm(lowerWord, set2)) result.add(word);
            } else if (set3.contains(lowerWord.charAt(0))) {
                if (canForm(lowerWord, set3)) result.add(word);
            }
        }

        return result.toArray(new String[0]);
    }

    private boolean canForm(String word, HashSet<Character> set) {
        for (char c : word.toCharArray()) {
            if (!set.contains(c)) return false;
        }
        return true;
    }
}