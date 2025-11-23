import java.util.ArrayList;
import java.util.List;

class Solution {
    public String[] findWords(String[] words) {
        String[] rows = {"qwertyuiopQWERTYUIOP", "asdfghjklASDFGHJKL", "zxcvbnmZXCVBNM"};
        List<String> result = new ArrayList<>();
        for (String word : words) {
            int row = -1;
            for (int i = 0; i < 3; i++) {
                if (rows[i].indexOf(word.charAt(0)) != -1) {
                    row = i;
                    break;
                }
            }
            boolean valid = true;
            for (int i = 1; i < word.length(); i++) {
                if (rows[row].indexOf(word.charAt(i)) == -1) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                result.add(word);
            }
        }
        return result.toArray(new String[0]);
    }
}