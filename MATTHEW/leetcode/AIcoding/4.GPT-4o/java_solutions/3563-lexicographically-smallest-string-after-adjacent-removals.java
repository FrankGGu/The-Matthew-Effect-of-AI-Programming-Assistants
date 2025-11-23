class Solution {
    public String smallestString(String s) {
        StringBuilder sb = new StringBuilder();
        for (char c : s.toCharArray()) {
            while (sb.length() > 0 && sb.charAt(sb.length() - 1) > c) {
                sb.deleteCharAt(sb.length() - 1);
            }
            sb.append(c);
        }

        String result = sb.toString();
        StringBuilder finalResult = new StringBuilder();
        for (char c : result.toCharArray()) {
            if (finalResult.length() > 0 && finalResult.charAt(finalResult.length() - 1) == c) {
                finalResult.deleteCharAt(finalResult.length() - 1);
            } else {
                finalResult.append(c);
            }
        }

        return finalResult.toString();
    }
}