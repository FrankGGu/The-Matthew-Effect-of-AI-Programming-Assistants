class Solution:
    def reconstructQueue(self, people: list[list[int]]) -> list[list[int]]:
        people.sort(key=lambda x: (-x[0], x[1]))

        reconstructed_queue = []
        for person in people:
            reconstructed_queue.insert(person[1], person)

        return reconstructed_queue