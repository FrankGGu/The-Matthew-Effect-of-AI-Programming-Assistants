class Encrypter {
    private Map<Character, String> keyToValue;
    private Map<String, Integer> dictionaryCount;

    public Encrypter(char[] keys, String[] values, String[] dictionary) {
        keyToValue = new HashMap<>();
        for (int i = 0; i < keys.length; i++) {
            keyToValue.put(keys[i], values[i]);
        }

        dictionaryCount = new HashMap<>();
        for (String word : dictionary) {
            String encrypted = encrypt(word);
            dictionaryCount.put(encrypted, dictionaryCount.getOrDefault(encrypted, 0) + 1);
        }
    }

    public String encrypt(String word1) {
        StringBuilder sb = new StringBuilder();
        for (char c : word1.toCharArray()) {
            sb.append(keyToValue.get(c));
        }
        return sb.toString();
    }

    public int decrypt(String word2) {
        return dictionaryCount.getOrDefault(word2, 0);
    }
}