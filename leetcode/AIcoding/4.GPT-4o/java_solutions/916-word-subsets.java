import java.util.*;

class Solution {
    public List<String> wordSubsets(String[] A, String[] B) {
        int[] bCount = new int[26];
        for (String b : B) {
            int[] tempCount = new int[26];
            for (char c : b.toCharArray()) {
                tempCount[c - 'a']++;
            }
            for (int i = 0; i < 26; i++) {
                bCount[i] = Math.max(bCount[i], tempCount[i]);
            }
        }

        List<String> result = new ArrayList<>();
        for (String a : A) {
            int[] aCount = new int[26];
            for (char c : a.toCharArray()) {
                aCount[c - 'a']++;
            }
            boolean isSubset = true;
            for (int i = 0; i < 26; i++) {
                if (aCount[i] < bCount[i]) {
                    isSubset = false;
                    break;
                }
            }
            if (isSubset) {
                result.add(a);
            }
        }

        return result;
    }
}