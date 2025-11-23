class Encrypter:

    def __init__(self, keys: List[str], values: List[str], dictionary: List[str]):
        self.key_map = dict(zip(keys, values))
        self.value_map = {}
        for i in range(len(values)):
            if values[i] not in self.value_map:
                self.value_map[values[i]] = []
            self.value_map[values[i]].append(keys[i])
        self.dictionary = dictionary
        self.valid_encryptions = set()
        for word in dictionary:
            encrypted = self.encrypt(word)
            if encrypted is not None:
                self.valid_encryptions.add(encrypted)

    def encrypt(self, word1: str) -> str:
        res = ""
        for char in word1:
            if char not in self.key_map:
                return None
            res += self.key_map[char]
        return res

    def decrypt(self, word2: str) -> int:
        return word2 in self.valid_encryptions