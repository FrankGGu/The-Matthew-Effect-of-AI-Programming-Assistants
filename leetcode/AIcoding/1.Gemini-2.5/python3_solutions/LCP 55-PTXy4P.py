from collections import defaultdict

class Solution:
    def totalFruit(self, fruits: list[int]) -> int:
        n = len(fruits)
        if n <= 2:
            return n

        max_fruits = 0
        left = 0
        fruit_counts = defaultdict(int)

        for right in range(n):
            fruit_counts[fruits[right]] += 1

            while len(fruit_counts) > 2:
                fruit_counts[fruits[left]] -= 1
                if fruit_counts[fruits[left]] == 0:
                    del fruit_counts[fruits[left]]
                left += 1

            max_fruits = max(max_fruits, right - left + 1)

        return max_fruits