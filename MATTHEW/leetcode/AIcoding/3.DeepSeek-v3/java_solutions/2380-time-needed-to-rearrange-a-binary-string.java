class Solution {
    public int secondsToRemoveOccurrences(String s) {
        int seconds = 0;
        char[] arr = s.toCharArray();
        boolean changed;
        do {
            changed = false;
            for (int i = 0; i < arr.length - 1; i++) {
                if (arr[i] == '0' && arr[i + 1] == '1') {
                    arr[i] = '1';
                    arr[i + 1] = '0';
                    changed = true;
                    i++;
                }
            }
            if (changed) {
                seconds++;
            }
        } while (changed);
        return seconds;
    }
}