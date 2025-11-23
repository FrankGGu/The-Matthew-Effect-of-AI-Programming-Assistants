class Solution {
    public List<String> printVertically(String s) {
        String[] words = s.split(" ");
        int maxLen = 0;
        for (String word : words) {
            maxLen = Math.max(maxLen, word.length());
        }
        List<String> result = new ArrayList<>();
        for (int i = 0; i < maxLen; i++) {
            StringBuilder sb = new StringBuilder();
            for (String word : words) {
                if (i < word.length()) {
                    sb.append(word.charAt(i));
                } else {
                    sb.append(' ');
                }
            }
            String str = sb.toString();
            int j = str.length() - 1;
            while (j >= 0 && str.charAt(j) == ' ') {
                j--;
            }
            result.add(str.substring(0, j + 1));
        }
        return result;
    }
}