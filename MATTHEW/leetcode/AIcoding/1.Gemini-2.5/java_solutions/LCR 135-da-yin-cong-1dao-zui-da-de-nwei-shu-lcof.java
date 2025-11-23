class Solution {
    public String countAndSay(int n) {
        if (n == 1) {
            return "1";
        }

        String s = countAndSay(n - 1);
        StringBuilder result = new StringBuilder();

        int i = 0;
        while (i < s.length()) {
            char currentChar = s.charAt(i);
            int count = 1;
            int j = i + 1;
            while (j < s.length() && s.charAt(j) == currentChar) {
                count++;
                j++;
            }
            result.append(count).append(currentChar);
            i = j;
        }
        return result.toString();
    }
}