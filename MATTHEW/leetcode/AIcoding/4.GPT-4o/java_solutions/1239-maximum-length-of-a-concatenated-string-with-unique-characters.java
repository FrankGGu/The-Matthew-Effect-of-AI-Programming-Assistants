import java.util.HashSet;

public class Solution {
    public int maxLength(List<String> arr) {
        return backtrack(arr, 0, new HashSet<>());
    }

    private int backtrack(List<String> arr, int index, HashSet<Character> used) {
        if (index == arr.size()) return used.size();

        int maxLen = backtrack(arr, index + 1, used);
        String current = arr.get(index);
        HashSet<Character> tempSet = new HashSet<>(used);

        if (canAdd(current, tempSet)) {
            for (char c : current.toCharArray()) {
                tempSet.add(c);
            }
            maxLen = Math.max(maxLen, backtrack(arr, index + 1, tempSet));
        }
        return maxLen;
    }

    private boolean canAdd(String str, HashSet<Character> used) {
        for (char c : str.toCharArray()) {
            if (used.contains(c)) return false;
        }
        return true;
    }
}