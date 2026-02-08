class Solution {
    public String reformatNumber(String number) {
        StringBuilder sb = new StringBuilder();
        for (char c : number.toCharArray()) {
            if (Character.isDigit(c)) {
                sb.append(c);
            }
        }

        StringBuilder result = new StringBuilder();
        int len = sb.length();
        int i = 0;
        while (i < len - 4) {
            result.append(sb.substring(i, i + 3)).append("-");
            i += 3;
        }

        if (len - i == 4) {
            result.append(sb.substring(i, i + 2)).append("-").append(sb.substring(i + 2, i + 4));
        } else if (len - i == 3) {
            result.append(sb.substring(i, i + 3));
        } else if (len - i == 2) {
            result.append(sb.substring(i, i + 2));
        }

        return result.toString();
    }
}