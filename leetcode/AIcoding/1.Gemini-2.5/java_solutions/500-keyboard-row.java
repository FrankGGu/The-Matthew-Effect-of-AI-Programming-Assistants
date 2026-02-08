import java.util.ArrayList;
import java.util.List;

class Solution {
    private final String row1 = "qwertyuiop";
    private final String row2 = "asdfghjkl";
    private final String row3 = "zxcvbnm";

    private int getRowIndex(char c) {
        c = Character.toLowerCase(c);
        if (row1.indexOf(c) != -1) return 0;
        if (row2.indexOf(c) != -1) return 1;
        if (row3.indexOf(c) != -1) return 2;
        return -1;
    }

    public String[] findWords(String[] words) {
        List<String> result = new ArrayList<>();

        for (String word : words) {
            if (word.isEmpty()) {
                continue;
            }

            int firstCharRow = getRowIndex(word.charAt(0));

            boolean allInOneRow = true;
            for (int i = 1; i < word.length(); i++) {
                if (getRowIndex(word.charAt(i)) != firstCharRow) {
                    allInOneRow = false;
                    break;
                }
            }

            if (allInOneRow) {
                result.add(word);
            }
        }

        return result.toArray(new String[0]);
    }
}