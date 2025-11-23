def maxFruits(fruits: List[int], k: int) -> int:
    n = len(fruits)
    left = 0
    total = 0
    max_fruits = 0

    for right in range(n):
        total += fruits[right]

        while right - left + 1 - total > k:
            total -= fruits[left]
            left += 1

        max_fruits = max(max_fruits, right - left + 1)

    return max_fruits