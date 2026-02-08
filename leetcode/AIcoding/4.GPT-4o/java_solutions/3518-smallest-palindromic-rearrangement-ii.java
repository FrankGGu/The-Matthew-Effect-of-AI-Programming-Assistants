class Solution {
    public String smallestPalindromic(String num) {
        int[] count = new int[10];
        for (char c : num.toCharArray()) {
            count[c - '0']++;
        }

        StringBuilder half = new StringBuilder();
        StringBuilder middle = new StringBuilder();

        for (int i = 0; i < 10; i++) {
            if (count[i] % 2 == 1) {
                if (middle.length() == 0 || middle.charAt(0) > i + '0') {
                    middle.setLength(0);
                    middle.append(i);
                }
            }
            half.append(String.valueOf(i).repeat(count[i] / 2));
        }

        if (half.length() == 0 && middle.length() == 0) return "0";

        char[] halfArr = half.toString().toCharArray();
        Arrays.sort(halfArr);
        String halfStr = new String(halfArr);

        StringBuilder result = new StringBuilder(halfStr);
        if (middle.length() > 0) {
            result.append(middle);
        }
        result.append(new StringBuilder(halfStr).reverse().toString());

        return result.toString();
    }
}