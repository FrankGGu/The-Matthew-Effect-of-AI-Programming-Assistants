class Solution {
    public String replaceWords(List<String> dictionary, String sentence) {
        Set<String> dict = new HashSet<>(dictionary);
        String[] words = sentence.split(" ");
        StringBuilder result = new StringBuilder();

        for (String word : words) {
            String prefix = "";
            for (int i = 1; i <= word.length(); i++) {
                prefix = word.substring(0, i);
                if (dict.contains(prefix)) {
                    break;
                }
            }
            if (result.length() > 0) {
                result.append(" ");
            }
            result.append(prefix);
        }

        return result.toString();
    }
}