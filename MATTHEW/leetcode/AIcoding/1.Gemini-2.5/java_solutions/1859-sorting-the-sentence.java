class Solution {
    public String sortSentence(String s) {
        String[] words = s.split(" ");
        String[] result = new String[words.length];

        for (String word : words) {
            int len = word.length();
            int position = Character.getNumericValue(word.charAt(len - 1)) - 1;
            result[position] = word.substring(0, len - 1);
        }

        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < result.length; i++) {
            sb.append(result[i]);
            if (i < result.length - 1) {
                sb.append(" ");
            }
        }

        return sb.toString();
    }
}