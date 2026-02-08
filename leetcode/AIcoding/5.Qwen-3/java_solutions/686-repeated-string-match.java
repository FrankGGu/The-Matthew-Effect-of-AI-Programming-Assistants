public class Solution {
    public int repeatedStringMatch(String a, String b) {
        int count = 1;
        StringBuilder sb = new StringBuilder(a);
        while (!sb.toString().contains(b)) {
            sb.append(a);
            count++;
            if (sb.length() > b.length() + a.length()) {
                return -1;
            }
        }
        return count;
    }
}