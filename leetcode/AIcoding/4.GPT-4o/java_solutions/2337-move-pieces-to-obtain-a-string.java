public class Solution {
    public boolean canChange(String start, String target) {
        if (start.replace("_", "").equals(target.replace("_", ""))) {
            int n = start.length();
            for (int i = 0, j = 0; i < n && j < n; ) {
                while (i < n && start.charAt(i) == '_') i++;
                while (j < n && target.charAt(j) == '_') j++;
                if (i < n && j < n) {
                    if (start.charAt(i) != target.charAt(j)) return false;
                    if (start.charAt(i) == 'L' && i < j) return false;
                    if (start.charAt(i) == 'R' && i > j) return false;
                    i++;
                    j++;
                } else if (i < n || j < n) {
                    return false;
                }
            }
            return true;
        }
        return false;
    }
}