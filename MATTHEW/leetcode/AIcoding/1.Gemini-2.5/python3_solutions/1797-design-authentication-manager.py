class AuthenticationManager:

    def __init__(self, timeToLive: int):
        self.timeToLive = timeToLive
        self.tokens = {} # Stores tokenId -> expirationTime

    def generate(self, tokenId: str, currentTime: int) -> None:
        self.tokens[tokenId] = currentTime + self.timeToLive

    def renew(self, tokenId: str, currentTime: int) -> None:
        if tokenId in self.tokens:
            if self.tokens[tokenId] > currentTime: # Check if the token is currently unexpired
                self.tokens[tokenId] = currentTime + self.timeToLive

    def countUnexpiredTokens(self, currentTime: int) -> int:
        count = 0
        # Iterate through all stored tokens and check their expiration status
        for expiration_time in self.tokens.values():
            if expiration_time > currentTime:
                count += 1
        return count