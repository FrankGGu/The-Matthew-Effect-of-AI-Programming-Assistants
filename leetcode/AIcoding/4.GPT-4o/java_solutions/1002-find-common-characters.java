import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<String> commonChars(String[] A) {
        int[] count = new int[26];
        for (char c : A[0].toCharArray()) {
            count[c - 'a']++;
        }
        for (int i = 1; i < A.length; i++) {
            int[] tempCount = new int[26];
            for (char c : A[i].toCharArray()) {
                tempCount[c - 'a']++;
            }
            for (int j = 0; j < 26; j++) {
                count[j] = Math.min(count[j], tempCount[j]);
            }
        }
        List<String> result = new ArrayList<>();
        for (int i = 0; i < 26; i++) {
            for (int j = 0; j < count[i]; j++) {
                result.add(String.valueOf((char) (i + 'a')));
            }
        }
        return result;
    }
}