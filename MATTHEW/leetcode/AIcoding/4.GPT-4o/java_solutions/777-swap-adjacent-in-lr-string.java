public class Solution {
    public boolean canTransform(String start, String end) {
        if (start.replace("X", "").equals(end.replace("X", ""))) {
            int i = 0, j = 0;
            while (i < start.length() || j < end.length()) {
                while (i < start.length() && start.charAt(i) == 'X') i++;
                while (j < end.length() && end.charAt(j) == 'X') j++;
                if (i < start.length() && j < end.length()) {
                    if (start.charAt(i) != end.charAt(j)) return false;
                    if (start.charAt(i) == 'L' && i < j) return false;
                    if (start.charAt(i) == 'R' && i > j) return false;
                    i++;
                    j++;
                } else {
                    return i == start.length() && j == end.length();
                }
            }
            return true;
        }
        return false;
    }
}