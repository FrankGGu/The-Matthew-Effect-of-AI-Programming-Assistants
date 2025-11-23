import java.util.List;

class Solution {
    int maxLength = 0;

    public int maxLength(List<String> arr) {
        backtrack(arr, 0, "");
        return maxLength;
    }

    private void backtrack(List<String> arr, int index, String current) {
        if (!isUnique(current)) {
            return;
        }

        maxLength = Math.max(maxLength, current.length());

        if (index == arr.size()) {
            return;
        }

        for (int i = index; i < arr.size(); i++) {
            backtrack(arr, i + 1, current + arr.get(i));
        }
    }

    private boolean isUnique(String s) {
        int[] count = new int[26];
        for (char c : s.toCharArray()) {
            if (count[c - 'a'] > 0) {
                return false;
            }
            count[c - 'a']++;
        }
        return true;
    }
}