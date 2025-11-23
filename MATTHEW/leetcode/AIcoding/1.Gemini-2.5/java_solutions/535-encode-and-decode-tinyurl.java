import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class Codec {

    private Map<String, String> shortToLong = new HashMap<>();
    private Map<String, String> longToShort = new HashMap<>();
    private String BASE_URL = "http://tinyurl.com/";
    private String ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private Random random = new Random();
    private int KEY_LENGTH = 6;

    private String generateRandomKey() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < KEY_LENGTH; i++) {
            sb.append(ALPHABET.charAt(random.nextInt(ALPHABET.length())));
        }
        return sb.toString();
    }

    public String encode(String longUrl) {
        if (longToShort.containsKey(longUrl)) {
            return BASE_URL + longToShort.get(longUrl);
        }

        String key;
        do {
            key = generateRandomKey();
        } while (shortToLong.containsKey(key));

        shortToLong.put(key, longUrl);
        longToShort.put(longUrl, key);
        return BASE_URL + key;
    }

    public String decode(String shortUrl) {
        String key = shortUrl.replace(BASE_URL, "");
        return shortToLong.get(key);
    }
}