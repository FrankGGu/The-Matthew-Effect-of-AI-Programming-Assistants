class CombinationIterator:

    def __init__(self, characters: str, combinationLength: int):
        self.characters = characters
        self.combinationLength = combinationLength
        self.combinations = []
        self.generate_combinations(0, "", 0)
        self.index = 0

    def generate_combinations(self, start_index: int, current_combination: str, length: int):
        if length == self.combinationLength:
            self.combinations.append(current_combination)
            return

        for i in range(start_index, len(self.characters)):
            self.generate_combinations(i + 1, current_combination + self.characters[i], length + 1)

    def next(self) -> str:
        result = self.combinations[self.index]
        self.index += 1
        return result

    def hasNext(self) -> bool:
        return self.index < len(self.combinations)