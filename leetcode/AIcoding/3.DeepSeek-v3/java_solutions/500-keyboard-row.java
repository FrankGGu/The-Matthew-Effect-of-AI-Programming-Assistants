class Solution {
    public String[] findWords(String[] words) {
        String[] rows = {"qwertyuiop", "asdfghjkl", "zxcvbnm"};
        List<String> result = new ArrayList<>();

        for (String word : words) {
            String lowerWord = word.toLowerCase();
            int row = -1;
            boolean isValid = true;

            for (int i = 0; i < 3; i++) {
                if (rows[i].indexOf(lowerWord.charAt(0)) != -1) {
                    row = i;
                    break;
                }
            }

            for (int j = 1; j < lowerWord.length(); j++) {
                if (rows[row].indexOf(lowerWord.charAt(j)) == -1) {
                    isValid = false;
                    break;
                }
            }

            if (isValid) {
                result.add(word);
            }
        }

        return result.toArray(new String[0]);
    }
}