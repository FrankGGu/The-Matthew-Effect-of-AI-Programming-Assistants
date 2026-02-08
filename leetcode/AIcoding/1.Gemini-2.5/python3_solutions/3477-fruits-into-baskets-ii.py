from collections import defaultdict

class Solution:
    def totalFruit(self, fruits: list[int]) -> int:
        fruit_counts = defaultdict(int)
        left = 0
        max_length = 0

        for right in range(len(fruits)):
            fruit_counts[fruits[right]] += 1

            while len(fruit_counts) > 2:
                fruit_counts[fruits[left]] -= 1
                if fruit_counts[fruits[left]] == 0:
                    del fruit_counts[fruits[left]]
                left += 1

            max_length = max(max_length, right - left + 1)

        return max_length