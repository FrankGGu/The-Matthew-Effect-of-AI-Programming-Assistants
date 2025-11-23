import java.util.HashSet;
import java.util.Set;

class Solution {
    public int numTilePossibilities(String tiles) {
        Set<String> result = new HashSet<>();
        boolean[] used = new boolean[tiles.length()];
        backtrack(tiles, used, "", result);
        return result.size();
    }

    private void backtrack(String tiles, boolean[] used, String current, Set<String> result) {
        if (!current.isEmpty()) {
            result.add(current);
        }

        for (int i = 0; i < tiles.length(); i++) {
            if (!used[i]) {
                used[i] = true;
                backtrack(tiles, used, current + tiles.charAt(i), result);
                used[i] = false;
            }
        }
    }
}