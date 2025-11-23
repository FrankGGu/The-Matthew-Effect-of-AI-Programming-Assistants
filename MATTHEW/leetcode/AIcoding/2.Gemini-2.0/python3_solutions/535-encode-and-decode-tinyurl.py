import random
import string

class Codec:
    def __init__(self):
        self.url_map = {}
        self.code_map = {}
        self.base = string.ascii_letters + string.digits

    def encode(self, longUrl):
        if longUrl in self.url_map:
            return self.url_map[longUrl]

        code = ''.join(random.choice(self.base) for _ in range(6))
        while code in self.code_map:
            code = ''.join(random.choice(self.base) for _ in range(6))

        self.code_map[code] = longUrl
        self.url_map[longUrl] = "http://tinyurl.com/" + code
        return "http://tinyurl.com/" + code

    def decode(self, shortUrl):
        code = shortUrl.split("/")[-1]
        return self.code_map[code]