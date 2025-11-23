class Solution:
    def splitIntoFibonacci(self, s: str) -> list[int]:
        n = len(s)
        res = []

        def backtrack(index, seq):
            if index == n:
                return len(seq) >= 3

            for i in range(index, n):
                if i > index and s[index] == '0':
                    break
                num = int(s[index:i + 1])
                if num > 2**31 - 1:
                    break

                if len(seq) >= 2:
                    if num > seq[-1] + seq[-2]:
                        break
                    elif num < seq[-1] + seq[-2]:
                        continue

                seq.append(num)
                if backtrack(i + 1, seq):
                    return True
                seq.pop()
            return False

        if backtrack(0, res):
            return res
        else:
            return []