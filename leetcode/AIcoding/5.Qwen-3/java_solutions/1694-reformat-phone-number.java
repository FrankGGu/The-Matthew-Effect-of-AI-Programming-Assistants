public class Solution {

class Solution {
    public String reformatNumber(String number) {
        StringBuilder sb = new StringBuilder();
        int count = 0;
        for (char c : number.toCharArray()) {
            if (Character.isDigit(c)) {
                sb.append(c);
                count++;
            }
        }
        StringBuilder result = new StringBuilder();
        int i = 0;
        while (i < sb.length()) {
            if (sb.length() - i == 4) {
                result.append(sb.substring(i, i + 2)).append("-");
                i += 2;
            } else {
                result.append(sb.substring(i, i + 3)).append("-");
                i += 3;
            }
        }
        return result.length() > 0 ? result.substring(0, result.length() - 1) : "";
    }
}
}