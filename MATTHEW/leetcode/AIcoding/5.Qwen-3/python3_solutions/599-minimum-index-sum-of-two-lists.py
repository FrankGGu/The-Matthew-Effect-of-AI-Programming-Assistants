class Solution:
    def findRestaurant(self, list1: List[str], list2: List[str]) -> List[str]:
        index_map = {word: i for i, word in enumerate(list1)}
        min_sum = float('inf')
        result = []

        for j, word in enumerate(list2):
            if word in index_map:
                total = j + index_map[word]
                if total < min_sum:
                    min_sum = total
                    result = [word]
                elif total == min_sum:
                    result.append(word)

        return result