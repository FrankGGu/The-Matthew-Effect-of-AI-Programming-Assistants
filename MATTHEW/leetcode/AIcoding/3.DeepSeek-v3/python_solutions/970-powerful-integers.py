class Solution:
    def powerfulIntegers(self, x: int, y: int, bound: int) -> List[int]:
        res = set()
        i = 0
        while True:
            a = x ** i
            if a > bound:
                break
            j = 0
            while True:
                b = y ** j
                if a + b > bound:
                    break
                res.add(a + b)
                if y == 1:
                    break
                j += 1
            if x == 1:
                break
            i += 1
        return list(res)