public class Solution {
    public int maxRepeating(String sequence, String pattern) {
        int count = 0;
        StringBuilder temp = new StringBuilder(pattern);
        while (sequence.contains(temp.toString())) {
            count++;
            temp.append(pattern);
        }
        return count;
    }
}