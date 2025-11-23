import java.util.HashSet;
import java.util.Set;

class Solution {
    public boolean hasAllCodes(String s, int k) {
        if (s.length() < k) {
            return false;
        }

        Set<Integer> seenCodes = new HashSet<>();
        int allPossibleCodes = 1 << k;

        for (int i = 0; i <= s.length() - k; i++) {
            String sub = s.substring(i, i + k);
            seenCodes.add(Integer.parseInt(sub, 2));
            if (seenCodes.size() == allPossibleCodes) {
                return true;
            }
        }

        return seenCodes.size() == allPossibleCodes;
    }
}