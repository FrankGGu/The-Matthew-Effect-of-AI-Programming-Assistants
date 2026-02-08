class NumberContainers:

    def __init__(self):
        self.number_to_index = {}
        self.index_to_number = {}

    def change(self, index: int, number: int) -> None:
        self.index_to_number[index] = number
        if number not in self.number_to_index:
            self.number_to_index[number] = set()
        self.number_to_index[number].add(index)
        for num, indices in self.number_to_index.items():
            if num != number and index in indices:
                indices.remove(index)
                if not indices:
                    del self.number_to_index[num]
                break

    def find(self, number: int) -> int:
        if number not in self.number_to_index:
            return -1

        indices = self.number_to_index[number]

        min_index = float('inf')
        for index in indices:
            if index in self.index_to_number and self.index_to_number[index] == number:
                min_index = min(min_index, index)

        if min_index == float('inf'):
            del self.number_to_index[number]
            return -1

        return min_index