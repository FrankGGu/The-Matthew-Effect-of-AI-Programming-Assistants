public class Solution {

class Solution {
    public int mostWordsFound(String[] sentences) {
        int max = 0;
        for (String s : sentences) {
            int count = 1;
            for (char c : s.toCharArray()) {
                if (c == ' ') {
                    count++;
                }
            }
            if (count > max) {
                max = count;
            }
        }
        return max;
    }
}
}