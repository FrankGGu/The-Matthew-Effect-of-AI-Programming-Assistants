class Solution:
    def splitIntoFibonacci(self, num: str) -> List[int]:
        n = len(num)
        for i in range(1, min(10, n)):
            for j in range(i + 1, min(i + 10, n)):
                part1 = num[:i]
                part2 = num[i:j]
                if (len(part1) > 1 and part1[0] == '0') or (len(part2) > 1 and part2[0] == '0'):
                    continue
                fib = []
                a, b = int(part1), int(part2)
                fib.append(a)
                fib.append(b)
                k = j
                while k < n:
                    c = a + b
                    c_str = str(c)
                    if num.startswith(c_str, k):
                        k += len(c_str)
                        a, b = b, c
                        fib.append(c)
                    else:
                        break
                if k == n and len(fib) >= 3:
                    return fib
        return []