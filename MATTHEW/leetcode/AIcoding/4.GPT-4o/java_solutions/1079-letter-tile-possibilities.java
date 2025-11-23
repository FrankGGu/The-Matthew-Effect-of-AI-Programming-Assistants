import java.util.HashSet;

public class Solution {
    public int numTilePossibilities(String tiles) {
        HashSet<String> set = new HashSet<>();
        backtrack(tiles, "", set);
        return set.size();
    }

    private void backtrack(String tiles, String current, HashSet<String> set) {
        if (!current.isEmpty()) {
            set.add(current);
        }
        for (int i = 0; i < tiles.length(); i++) {
            backtrack(tiles.substring(0, i) + tiles.substring(i + 1), current + tiles.charAt(i), set);
        }
    }
}