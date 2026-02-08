class Solution:
    def totalFruit(self, fruits: list[int]) -> int:
        max_len = 0
        left = 0
        fruit_counts = {}

        for right in range(len(fruits)):
            fruit = fruits[right]
            fruit_counts[fruit] = fruit_counts.get(fruit, 0) + 1

            while len(fruit_counts) > 2:
                left_fruit = fruits[left]
                fruit_counts[left_fruit] -= 1
                if fruit_counts[left_fruit] == 0:
                    del fruit_counts[left_fruit]
                left += 1

            max_len = max(max_len, right - left + 1)

        return max_len