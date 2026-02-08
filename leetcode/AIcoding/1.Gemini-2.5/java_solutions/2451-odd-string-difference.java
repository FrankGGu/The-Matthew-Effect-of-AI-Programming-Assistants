import java.util.ArrayList;
import java.util.List;

class Solution {
    private List<Integer> getDifferenceArray(String s) {
        List<Integer> diffArray = new ArrayList<>();
        for (int i = 0; i < s.length() - 1; i++) {
            diffArray.add(s.charAt(i + 1) - s.charAt(i));
        }
        return diffArray;
    }

    public String oddString(String[] words) {
        List<Integer> d0 = getDifferenceArray(words[0]);
        List<Integer> d1 = getDifferenceArray(words[1]);
        List<Integer> d2 = getDifferenceArray(words[2]);

        if (d0.equals(d1)) {
            if (!d2.equals(d0)) {
                return words[2];
            }
            for (int i = 3; i < words.length; i++) {
                if (!getDifferenceArray(words[i]).equals(d0)) {
                    return words[i];
                }
            }
        } else { 
            if (d0.equals(d2)) {
                return words[1];
            } else {
                return words[0];
            }
        }
        return null; 
    }
}