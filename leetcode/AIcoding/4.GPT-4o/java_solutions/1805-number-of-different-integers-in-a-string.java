import java.util.HashSet;

class Solution {
    public int numDifferentIntegers(String word) {
        HashSet<String> set = new HashSet<>();
        StringBuilder num = new StringBuilder();

        for (char c : word.toCharArray()) {
            if (Character.isDigit(c)) {
                num.append(c);
            } else {
                if (num.length() > 0) {
                    set.add(num.toString().replaceAll("^0+", ""));
                    num.setLength(0);
                }
            }
        }

        if (num.length() > 0) {
            set.add(num.toString().replaceAll("^0+", ""));
        }

        return set.size();
    }
}