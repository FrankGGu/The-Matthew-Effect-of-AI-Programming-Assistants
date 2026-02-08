class Solution:
    def minimumAddition(self, n: int, target: int) -> int:
        def is_beautiful(num):
            return sum(int(d) for d in str(num)) <= target

        addition = 0
        while not is_beautiful(n + addition):
            addition += 1
        return addition