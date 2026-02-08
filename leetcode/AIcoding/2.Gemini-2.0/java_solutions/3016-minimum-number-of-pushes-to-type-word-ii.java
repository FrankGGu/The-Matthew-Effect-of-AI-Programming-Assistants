import java.util.Arrays;

class Solution {
    public int minimumPushes(String word) {
        int[] count = new int[26];
        for (char c : word.toCharArray()) {
            count[c - 'a']++;
        }
        Arrays.sort(count);
        int ans = 0;
        int pushes = 1;
        int added = 0;
        for (int i = 25; i >= 0; i--) {
            if (count[i] == 0) break;
            ans += pushes * count[i];
            added++;
            if (added == 8) {
                pushes++;
                added = 0;
            }
            if (pushes == 4 && added == 0) return ans;
        }
        return ans;
    }
}