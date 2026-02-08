import java.util.ArrayList;
import java.util.List;

class Solution {
    public String reformat(String s) {
        List<Character> digits = new ArrayList<>();
        List<Character> letters = new ArrayList<>();

        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                digits.add(c);
            } else {
                letters.add(c);
            }
        }

        int diff = Math.abs(digits.size() - letters.size());

        if (diff > 1) {
            return "";
        }

        StringBuilder sb = new StringBuilder();
        List<Character> longerList;
        List<Character> shorterList;

        if (digits.size() >= letters.size()) {
            longerList = digits;
            shorterList = letters;
        } else {
            longerList = letters;
            shorterList = digits;
        }

        for (int i = 0; i < shorterList.size(); i++) {
            sb.append(longerList.get(i));
            sb.append(shorterList.get(i));
        }

        if (longerList.size() > shorterList.size()) {
            sb.append(longerList.get(longerList.size() - 1));
        }

        return sb.toString();
    }
}