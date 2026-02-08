import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class Codec {

    private Map<String, String> urlMap = new HashMap<>();
    private Map<String, String> tinyMap = new HashMap<>();
    private static final String BASE_URL = "http://tinyurl.com/";
    private static final String CHARACTERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private static final int KEY_LENGTH = 6;
    private Random random = new Random();

    public String encode(String longUrl) {
        if (urlMap.containsKey(longUrl)) {
            return urlMap.get(longUrl);
        }

        String tinyUrl;
        String key;
        do {
            key = generateRandomKey();
            tinyUrl = BASE_URL + key;
        } while (tinyMap.containsKey(tinyUrl));

        urlMap.put(longUrl, tinyUrl);
        tinyMap.put(tinyUrl, longUrl);
        return tinyUrl;
    }

    public String decode(String shortUrl) {
        return tinyMap.getOrDefault(shortUrl, "");
    }

    private String generateRandomKey() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < KEY_LENGTH; i++) {
            int index = random.nextInt(CHARACTERS.length());
            sb.append(CHARACTERS.charAt(index));
        }
        return sb.toString();
    }
}