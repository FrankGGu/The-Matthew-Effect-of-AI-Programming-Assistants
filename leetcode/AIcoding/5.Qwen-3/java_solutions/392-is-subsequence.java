public class Solution {
    public boolean isSubsequence(int s, int t) {
        int i = 0;
        int j = 0;
        while (i < s && j < t) {
            if (s(i) == t(j)) {
                i++;
            }
            j++;
        }
        return i == s;
    }
}