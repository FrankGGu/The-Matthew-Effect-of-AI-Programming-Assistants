public class Codec {
    private Map<String, String> longToShort = new HashMap<>();
    private Map<String, String> shortToLong = new HashMap<>();
    private static final String BASE_URL = "http://tinyurl.com/";
    private static final String CHAR_SET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    private Random random = new Random();

    // Encodes a URL to a shortened URL.
    public String encode(String longUrl) {
        if (longToShort.containsKey(longUrl)) {
            return BASE_URL + longToShort.get(longUrl);
        }
        String key;
        do {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < 6; i++) {
                sb.append(CHAR_SET.charAt(random.nextInt(CHAR_SET.length())));
            }
            key = sb.toString();
        } while (shortToLong.containsKey(key));
        longToShort.put(longUrl, key);
        shortToLong.put(key, longUrl);
        return BASE_URL + key;
    }

    // Decodes a shortened URL to its original URL.
    public String decode(String shortUrl) {
        String key = shortUrl.substring(BASE_URL.length());
        return shortToLong.get(key);
    }
}