class Solution:
    def totalFruit(self, fruits: List[int]) -> int:
        from collections import defaultdict
        basket = defaultdict(int)
        left = max_fruits = 0

        for right, fruit in enumerate(fruits):
            basket[fruit] += 1

            while len(basket) > 2:
                left_fruit = fruits[left]
                basket[left_fruit] -= 1
                if basket[left_fruit] == 0:
                    del basket[left_fruit]
                left += 1

            max_fruits = max(max_fruits, right - left + 1)

        return max_fruits