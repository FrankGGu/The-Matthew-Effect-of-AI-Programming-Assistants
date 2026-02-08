class Solution:
    def orchestraLayout(self, num: int, row: int, col: int) -> int:
        n = num
        r, c = row, col
        level = 0
        while r >= n - 2 * level or c >= n - 2 * level:
            level += 1

        length = n - 2 * level
        start = (n - 2 * (level - 1)) * 4 - 4
        val = (start * (level - 1)) % 9

        if r == level - 1:
            val += (c - (level - 1) + 1)
        elif c == n - level:
            val += (length + r - (level - 1))
        elif r == n - level:
            val += (length * 2 + (n - level) - c)
        else:
            val += (length * 3 + (n - level) - r)

        return (val - 1) % 9 + 1