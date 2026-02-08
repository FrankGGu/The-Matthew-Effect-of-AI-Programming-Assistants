import java.util.HashMap;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;

class Encrypter {

    private Map<Character, String> encMap;
    private Map<String, Character> decMap;
    private String[] dictionary;

    public Encrypter(char[] keys, String[] values, String[] dictionary) {
        encMap = new HashMap<>();
        decMap = new HashMap<>();
        for (int i = 0; i < keys.length; i++) {
            encMap.put(keys[i], values[i]);
            decMap.put(values[i], keys[i]);
        }
        this.dictionary = dictionary;
    }

    public String encrypt(String word1) {
        StringBuilder sb = new StringBuilder();
        for (char c : word1.toCharArray()) {
            if (!encMap.containsKey(c)) {
                return "";
            }
            sb.append(encMap.get(c));
        }
        return sb.toString();
    }

    public int decrypt(String word2) {
        int count = 0;
        for (String s : dictionary) {
            if (encrypt(s).equals(word2)) {
                count++;
            }
        }
        return count;
    }
}