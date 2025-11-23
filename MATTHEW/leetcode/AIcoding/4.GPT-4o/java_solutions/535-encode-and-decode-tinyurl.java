import java.util.HashMap;
import java.util.Random;

public class Codec {
    private final String BASE_URL = "http://tinyurl.com/";
    private final HashMap<String, String> urlMap = new HashMap<>();
    private final Random random = new Random();

    public String encode(String longUrl) {
        String key = generateKey();
        urlMap.put(key, longUrl);
        return BASE_URL + key;
    }

    public String decode(String shortUrl) {
        String key = shortUrl.replace(BASE_URL, "");
        return urlMap.get(key);
    }

    private String generateKey() {
        StringBuilder key = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            int index = random.nextInt(62);
            char ch = (char) (index < 10 ? '0' + index : index < 36 ? 'a' + (index - 10) : 'A' + (index - 36));
            key.append(ch);
        }
        return key.toString();
    }
}