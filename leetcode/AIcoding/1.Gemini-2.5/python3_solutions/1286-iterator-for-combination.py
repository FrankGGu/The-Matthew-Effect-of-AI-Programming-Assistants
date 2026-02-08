import itertools

class CombinationIterator:

    def __init__(self, characters: str, combinationLength: int):
        self.combinations = []
        chars_list = sorted(list(characters))
        for combo_tuple in itertools.combinations(chars_list, combinationLength):
            self.combinations.append("".join(combo_tuple))

        self.current_index = 0

    def next(self) -> str:
        result = self.combinations[self.current_index]
        self.current_index += 1
        return result

    def hasNext(self) -> bool:
        return self.current_index < len(self.combinations)