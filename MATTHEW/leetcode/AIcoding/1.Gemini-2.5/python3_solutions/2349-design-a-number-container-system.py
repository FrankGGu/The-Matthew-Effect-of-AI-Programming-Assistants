import heapq

class NumberContainers:

    def __init__(self):
        self.index_to_number = {}
        self.number_to_indices = {}

    def change(self, index: int, number: int) -> None:
        self.index_to_number[index] = number
        heapq.heappush(self.number_to_indices.setdefault(number, []), index)

    def find(self, number: int) -> int:
        if number not in self.number_to_indices:
            return -1

        heap = self.number_to_indices[number]

        while heap:
            smallest_index = heap[0]

            if self.index_to_number.get(smallest_index) == number:
                return smallest_index
            else:
                heapq.heappop(heap)

        return -1