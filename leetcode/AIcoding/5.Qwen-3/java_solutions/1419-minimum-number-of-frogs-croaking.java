public class Solution {
    public int minNumberOfFrogsCroaking(String croak) {
        int[] count = new int[26];
        int[] index = new int[26];
        for (int i = 0; i < 26; i++) {
            index[i] = -1;
        }
        String order = "croak";
        for (int i = 0; i < order.length(); i++) {
            index[order.charAt(i) - 'a'] = i;
        }
        int result = 0;
        for (int i = 0; i < croak.length(); i++) {
            char c = croak.charAt(i);
            int pos = index[c - 'a'];
            if (pos == -1) return -1;
            if (pos == 0) {
                count[0]++;
                result = Math.max(result, count[0]);
            } else {
                if (count[pos - 1] == 0) return -1;
                count[pos - 1]--;
                count[pos]++;
            }
        }
        for (int i = 1; i < 5; i++) {
            if (count[i] != 0) return -1;
        }
        return result;
    }
}