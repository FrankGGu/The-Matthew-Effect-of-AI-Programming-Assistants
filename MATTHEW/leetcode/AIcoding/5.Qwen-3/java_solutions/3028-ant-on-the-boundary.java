public class Solution {
    public int countOperations(String s) {
        int count = 0;
        int i = 0;
        int j = s.length() - 1;
        while (i < j) {
            if (s.charAt(i) != s.charAt(j)) {
                count++;
            }
            i++;
            j--;
        }
        return count;
    }
}