class CombinationIterator:

    def __init__(self, characters: str, combinationLength: int):
        self.combinations = []
        self.index = 0
        self.generate_combinations(characters, combinationLength, 0, "")

    def generate_combinations(self, s, k, start, path):
        if k == 0:
            self.combinations.append(path)
            return
        for i in range(start, len(s)):
            self.generate_combinations(s, k-1, i+1, path + s[i])

    def next(self) -> str:
        res = self.combinations[self.index]
        self.index += 1
        return res

    def hasNext(self) -> bool:
        return self.index < len(self.combinations)