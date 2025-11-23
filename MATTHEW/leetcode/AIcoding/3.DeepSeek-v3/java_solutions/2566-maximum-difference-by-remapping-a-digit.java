class Solution {
    public int minMaxDifference(int num) {
        String s = Integer.toString(num);
        char[] maxChars = s.toCharArray();
        char[] minChars = s.toCharArray();

        char targetMax = '9';
        for (char c : maxChars) {
            if (c != '9') {
                targetMax = c;
                break;
            }
        }

        char targetMin = minChars[0];

        for (int i = 0; i < maxChars.length; i++) {
            if (maxChars[i] == targetMax) {
                maxChars[i] = '9';
            }
        }

        for (int i = 0; i < minChars.length; i++) {
            if (minChars[i] == targetMin) {
                minChars[i] = '0';
            }
        }

        int max = Integer.parseInt(new String(maxChars));
        int min = Integer.parseInt(new String(minChars));

        return max - min;
    }
}