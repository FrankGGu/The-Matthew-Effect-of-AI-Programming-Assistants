class Solution:
    def sortPeople(self, names: list[str], heights: list[int]) -> list[str]:
        combined = []
        for i in range(len(names)):
            combined.append((heights[i], names[i]))

        combined.sort(key=lambda x: x[0], reverse=True)

        sorted_names = [item[1] for item in combined]
        return sorted_names