class Encrypter:

    def __init__(self, keys: List[str], values: List[str], dictionary: List[str]):
        self.key_to_val = {}
        self.val_to_keys = {}
        for k, v in zip(keys, values):
            self.key_to_val[k] = v
            if v not in self.val_to_keys:
                self.val_to_keys[v] = []
            self.val_to_keys[v].append(k)
        self.dictionary = dictionary

    def encrypt(self, word1: str) -> str:
        res = []
        for c in word1:
            if c in self.key_to_val:
                res.append(self.key_to_val[c])
            else:
                return ""
        return "".join(res)

    def decrypt(self, word2: str) -> int:
        count = 0
        for word in self.dictionary:
            if len(word) * 2 != len(word2):
                continue
            valid = True
            for i in range(len(word)):
                c = word[i]
                val = word2[2*i:2*i+2]
                if val not in self.val_to_keys or c not in self.val_to_keys[val]:
                    valid = False
                    break
            if valid:
                count += 1
        return count