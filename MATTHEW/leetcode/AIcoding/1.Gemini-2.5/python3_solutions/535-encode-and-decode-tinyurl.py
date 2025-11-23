class Codec:
    def __init__(self):
        self.longToShort = {}
        self.shortToLong = {}
        self.base_url = "http://tinyurl.com/"
        self.counter = 0

    def encode(self, longUrl: str) -> str:
        if longUrl in self.longToShort:
            return self.longToShort[longUrl]

        suffix = str(self.counter)
        self.counter += 1

        shortUrl = self.base_url + suffix

        self.longToShort[longUrl] = shortUrl
        self.shortToLong[shortUrl] = longUrl

        return shortUrl

    def decode(self, shortUrl: str) -> str:
        return self.shortToLong[shortUrl]