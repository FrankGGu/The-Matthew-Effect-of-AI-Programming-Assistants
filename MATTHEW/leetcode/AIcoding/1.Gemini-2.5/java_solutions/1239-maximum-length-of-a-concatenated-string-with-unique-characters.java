import java.util.List;

class Solution {
    int maxLength = 0;

    public int maxLength(List<String> arr) {
        maxLength = 0;
        dfs(arr, 0, 0, 0);
        return maxLength;
    }

    private void dfs(List<String> arr, int index, int currentMask, int currentLength) {
        maxLength = Math.max(maxLength, currentLength);

        if (index == arr.size()) {
            return;
        }

        dfs(arr, index + 1, currentMask, currentLength);

        String s = arr.get(index);
        int wordMask = 0;
        boolean uniqueInWord = true;

        for (char c : s.toCharArray()) {
            int bit = 1 << (c - 'a');
            if ((wordMask & bit) != 0) {
                uniqueInWord = false;
                break;
            }
            wordMask |= bit;
        }

        if (uniqueInWord) {
            if ((currentMask & wordMask) == 0) {
                dfs(arr, index + 1, currentMask | wordMask, currentLength + s.length());
            }
        }
    }
}