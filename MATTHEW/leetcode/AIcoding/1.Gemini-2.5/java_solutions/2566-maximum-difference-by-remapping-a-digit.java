class Solution {
    public int maxDiff(int num) {
        String s = String.valueOf(num);

        char firstNonNine = ' ';
        for (char c : s.toCharArray()) {
            if (c != '9') {
                firstNonNine = c;
                break;
            }
        }

        String maxStr;
        if (firstNonNine == ' ') { // All digits are '9'
            maxStr = s;
        } else {
            maxStr = s.replace(firstNonNine, '9');
        }

        char firstDigit = s.charAt(0);
        String minStr = s.replace(firstDigit, '0');

        return Integer.parseInt(maxStr) - Integer.parseInt(minStr);
    }
}