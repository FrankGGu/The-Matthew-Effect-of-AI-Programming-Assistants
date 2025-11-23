class Solution:
    def advantageCount(self, A: List[int], B: List[int]) -> List[int]:
        sortedA = sorted(A)
        sortedB = sorted([(num, i) for i, num in enumerate(B)], key=lambda x: x[0])

        res = [0] * len(A)
        remaining = []
        ptrA = ptrB = 0

        for num in sortedA:
            if num > sortedB[ptrB][0]:
                res[sortedB[ptrB][1]] = num
                ptrB += 1
            else:
                remaining.append(num)

        for i in range(len(remaining)):
            res[sortedB[ptrB + i][1]] = remaining[i]

        return res