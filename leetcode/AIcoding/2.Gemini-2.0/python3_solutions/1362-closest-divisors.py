class Solution:
    def closestDivisors(self, num: int) -> list[int]:
        def find_closest(n):
            a, b = 1, n
            for i in range(1, int(n**0.5) + 1):
                if n % i == 0:
                    if abs(i - n // i) < abs(a - b):
                        a, b = i, n // i
            return a, b

        a1, b1 = find_closest(num + 1)
        a2, b2 = find_closest(num + 2)

        if abs(a1 - b1) <= abs(a2 - b2):
            return [a1, b1]
        else:
            return [a2, b2]