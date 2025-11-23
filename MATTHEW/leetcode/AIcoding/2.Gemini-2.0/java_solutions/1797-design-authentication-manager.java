import java.util.HashMap;
import java.util.Map;

class AuthenticationManager {

    private int timeToLive;
    private Map<String, Integer> tokenExpiration;

    public AuthenticationManager(int timeToLive) {
        this.timeToLive = timeToLive;
        this.tokenExpiration = new HashMap<>();
    }

    public void generate(String tokenId, int currentTime) {
        tokenExpiration.put(tokenId, currentTime + timeToLive);
    }

    public void renew(String tokenId, int currentTime) {
        if (tokenExpiration.containsKey(tokenId) && tokenExpiration.get(tokenId) > currentTime) {
            tokenExpiration.put(tokenId, currentTime + timeToLive);
        }
    }

    public int countUnexpiredTokens(int currentTime) {
        int count = 0;
        for (int expirationTime : tokenExpiration.values()) {
            if (expirationTime > currentTime) {
                count++;
            }
        }
        return count;
    }
}