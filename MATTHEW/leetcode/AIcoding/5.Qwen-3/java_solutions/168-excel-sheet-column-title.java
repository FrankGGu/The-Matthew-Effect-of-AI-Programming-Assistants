public class Solution {
    public String convertToTitle(int columnNumber) {
        StringBuilder title = new StringBuilder();
        while (columnNumber > 0) {
            int remainder = columnNumber % 26;
            if (remainder == 0) {
                title.append('Z');
                columnNumber = columnNumber / 26 - 1;
            } else {
                title.append((char) ('A' + remainder - 1));
                columnNumber = columnNumber / 26;
            }
        }
        return title.reverse().toString();
    }
}