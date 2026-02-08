public class Solution {
    public boolean areNumbersAscending(String s) {
        int prev = -1;
        for (String word : s.split(" ")) {
            if (isNumeric(word)) {
                int current = Integer.parseInt(word);
                if (current <= prev) {
                    return false;
                }
                prev = current;
            }
        }
        return true;
    }

    private boolean isNumeric(String str) {
        try {
            Integer.parseInt(str);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}