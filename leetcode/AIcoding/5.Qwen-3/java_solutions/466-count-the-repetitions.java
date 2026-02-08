public class Solution {
    public int countCharacters(String s, String m, int n) {
        int[] count = new int[256];
        for (char c : s.toCharArray()) {
            count[c]++;
        }
        int result = 0;
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m.length(); j++) {
                char c = m.charAt(j);
                if (count[c] == 0) {
                    return result;
                }
                count[c]--;
            }
            result++;
        }
        return result;
    }
}