class AuthenticationManager:

    def __init__(self, timeToLive: int):
        self.timeToLive = timeToLive
        self.token_map = {}

    def generate(self, tokenId: str, currentTime: int) -> None:
        self.token_map[tokenId] = currentTime + self.timeToLive

    def renew(self, tokenId: str, currentTime: int) -> None:
        if tokenId in self.token_map and self.token_map[tokenId] > currentTime:
            self.token_map[tokenId] = currentTime + self.timeToLive

    def countUnexpiredTokens(self, currentTime: int) -> int:
        count = 0
        for expiry in self.token_map.values():
            if expiry > currentTime:
                count += 1
        return count