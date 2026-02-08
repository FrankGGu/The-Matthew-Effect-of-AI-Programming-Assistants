class AuthenticationManager {
    private int timeToLive;
    private Map<String, Integer> tokenMap;

    public AuthenticationManager(int timeToLive) {
        this.timeToLive = timeToLive;
        this.tokenMap = new HashMap<>();
    }

    public void generate(String tokenId, int currentTime) {
        tokenMap.put(tokenId, currentTime + timeToLive);
    }

    public void renew(String tokenId, int currentTime) {
        if (tokenMap.containsKey(tokenId) && tokenMap.get(tokenId) > currentTime) {
            tokenMap.put(tokenId, currentTime + timeToLive);
        }
    }

    public int countUnexpiredTokens(int currentTime) {
        int count = 0;
        for (int expiryTime : tokenMap.values()) {
            if (expiryTime > currentTime) {
                count++;
            }
        }
        return count;
    }
}