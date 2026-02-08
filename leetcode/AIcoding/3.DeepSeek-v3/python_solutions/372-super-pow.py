class Solution:
    def superPow(self, a: int, b: List[int]) -> int:
        mod = 1337
        if not b:
            return 1
        last = b.pop()
        part1 = pow(a, last, mod)
        part2 = pow(self.superPow(a, b), 10, mod)
        return (part1 * part2) % mod