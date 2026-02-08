import java.util.HashMap;
import java.util.Map;

class Encrypter {
    private Map<Character, String> keyToValueMap;
    private Map<String, Integer> encryptedDictionaryCounts;

    public Encrypter(char[] keys, String[] values, String[] dictionary) {
        keyToValueMap = new HashMap<>();
        for (int i = 0; i < keys.length; i++) {
            keyToValueMap.put(keys[i], values[i]);
        }

        encryptedDictionaryCounts = new HashMap<>();
        for (String word : dictionary) {
            String encryptedWord = encrypt(word);
            encryptedDictionaryCounts.put(encryptedWord, encryptedDictionaryCounts.getOrDefault(encryptedWord, 0) + 1);
        }
    }

    public String encrypt(String word1) {
        StringBuilder sb = new StringBuilder();
        for (char c : word1.toCharArray()) {
            String val = keyToValueMap.get(c);
            // According to problem constraints, all characters of word1 are present in keys.
            // So val will not be null.
            sb.append(val);
        }
        return sb.toString();
    }

    public int decrypt(String word2) {
        return encryptedDictionaryCounts.getOrDefault(word2, 0);
    }
}