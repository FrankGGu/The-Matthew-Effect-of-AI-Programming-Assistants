import random
import string

class Codec:
    def __init__(self):
        self.url_map = {}
        self.base = "http://tinyurl.com/"
        self.chars = string.ascii_letters + string.digits

    def encode(self, longUrl: str) -> str:
        short_key = ''.join(random.choices(self.chars, k=6))
        while short_key in self.url_map:
            short_key = ''.join(random.choices(self.chars, k=6))
        self.url_map[short_key] = longUrl
        return self.base + short_key

    def decode(self, shortUrl: str) -> str:
        short_key = shortUrl.split('/')[-1]
        return self.url_map.get(short_key, "")