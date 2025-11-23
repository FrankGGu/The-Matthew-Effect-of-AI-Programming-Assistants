class Solution {
    public String[] spellchecker(String[] wordlist, String[] queries) {
        Set<String> exactMatch = new HashSet<>();
        Map<String, String> caseInsensitive = new HashMap<>();
        Map<String, String> vowelError = new HashMap<>();

        for (String word : wordlist) {
            exactMatch.add(word);

            String lowerWord = word.toLowerCase();
            caseInsensitive.putIfAbsent(lowerWord, word);

            String devowel = devowel(lowerWord);
            vowelError.putIfAbsent(devowel, word);
        }

        String[] result = new String[queries.length];
        for (int i = 0; i < queries.length; i++) {
            String query = queries[i];
            if (exactMatch.contains(query)) {
                result[i] = query;
                continue;
            }

            String lowerQuery = query.toLowerCase();
            if (caseInsensitive.containsKey(lowerQuery)) {
                result[i] = caseInsensitive.get(lowerQuery);
                continue;
            }

            String devowelQuery = devowel(lowerQuery);
            if (vowelError.containsKey(devowelQuery)) {
                result[i] = vowelError.get(devowelQuery);
                continue;
            }

            result[i] = "";
        }
        return result;
    }

    private String devowel(String word) {
        StringBuilder sb = new StringBuilder();
        for (char c : word.toCharArray()) {
            sb.append(isVowel(c) ? '*' : c);
        }
        return sb.toString();
    }

    private boolean isVowel(char c) {
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }
}