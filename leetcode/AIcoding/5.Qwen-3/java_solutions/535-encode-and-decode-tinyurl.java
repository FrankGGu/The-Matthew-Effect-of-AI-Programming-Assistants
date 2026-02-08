public class Codec {
    private int count = 0;
    private String[] map = new String[1000000];

    // Encodes a URL to a shortened URL.
    public String encode(String longUrl) {
        map[count] = longUrl;
        return "http://tinyurl.com/" + count++;
    }

    // Decodes a shortened URL to its original URL.
    public String decode(String shortUrl) {
        int index = Integer.parseInt(shortUrl.substring(19));
        return map[index];
    }
}