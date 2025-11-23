from collections import defaultdict

class Solution:
    def totalFruit(self, fruits: list[int]) -> int:
        fruit_counts = defaultdict(int)
        left = 0
        max_fruits = 0

        max_distinct_types = 3 

        for right in range(len(fruits)):
            fruit_counts[fruits[right]] += 1

            while len(fruit_counts) > max_distinct_types:
                fruit_counts[fruits[left]] -= 1
                if fruit_counts[fruits[left]] == 0:
                    del fruit_counts[fruits[left]]
                left += 1

            max_fruits = max(max_fruits, right - left + 1)

        return max_fruits