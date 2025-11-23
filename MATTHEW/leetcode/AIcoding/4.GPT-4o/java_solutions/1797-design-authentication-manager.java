import java.util.HashMap;
import java.util.Map;

class AuthenticationManager {
    private Map<String, Integer> tokens;
    private int timeToLive;

    public AuthenticationManager(int timeToLive) {
        this.tokens = new HashMap<>();
        this.timeToLive = timeToLive;
    }

    public void generate(String tokenId, int currentTime) {
        tokens.put(tokenId, currentTime + timeToLive);
    }

    public void renew(String tokenId, int currentTime) {
        if (tokens.containsKey(tokenId) && tokens.get(tokenId) > currentTime) {
            tokens.put(tokenId, currentTime + timeToLive);
        }
    }

    public int countUnexpiredTokens(int currentTime) {
        int count = 0;
        for (int expiryTime : tokens.values()) {
            if (expiryTime > currentTime) {
                count++;
            }
        }
        return count;
    }
}