import java.util.HashMap;
import java.util.Map;

class AuthenticationManager {
    private int timeToLive;
    private Map<String, Integer> tokenExpirationMap;

    public AuthenticationManager(int timeToLive) {
        this.timeToLive = timeToLive;
        this.tokenExpirationMap = new HashMap<>();
    }

    public void generate(String tokenId, int currentTime) {
        tokenExpirationMap.put(tokenId, currentTime + timeToLive);
    }

    public void renew(String tokenId, int currentTime) {
        if (tokenExpirationMap.containsKey(tokenId)) {
            int expirationTime = tokenExpirationMap.get(tokenId);
            if (currentTime < expirationTime) {
                tokenExpirationMap.put(tokenId, currentTime + timeToLive);
            }
        }
    }

    public int countUnexpiredTokens(int currentTime) {
        int count = 0;
        for (int expirationTime : tokenExpirationMap.values()) {
            if (currentTime < expirationTime) {
                count++;
            }
        }
        return count;
    }
}