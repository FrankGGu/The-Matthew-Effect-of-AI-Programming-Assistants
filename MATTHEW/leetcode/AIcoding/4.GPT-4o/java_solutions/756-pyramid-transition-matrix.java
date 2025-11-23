import java.util.HashSet;
import java.util.Set;

public class Solution {
    public boolean pyramidTransition(String bottom, List<String> allowed) {
        Set<String> allowedSet = new HashSet<>(allowed);
        return canBuildPyramid(bottom, allowedSet);
    }

    private boolean canBuildPyramid(String bottom, Set<String> allowed) {
        if (bottom.length() == 1) {
            return true;
        }

        Set<String> nextLevel = new HashSet<>();

        for (int i = 0; i < bottom.length() - 1; i++) {
            String pair = bottom.substring(i, i + 2);
            for (char c : getAllowedChars(pair, allowed)) {
                nextLevel.add(bottom.substring(0, i) + c + bottom.substring(i + 2));
            }
        }

        for (String next : nextLevel) {
            if (canBuildPyramid(next, allowed)) {
                return true;
            }
        }

        return false;
    }

    private Set<Character> getAllowedChars(String pair, Set<String> allowed) {
        Set<Character> chars = new HashSet<>();
        for (String s : allowed) {
            if (s.startsWith(pair)) {
                chars.add(s.charAt(2));
            }
        }
        return chars;
    }
}