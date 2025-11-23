class Solution:
    def recoverArray(self, n: int, sums: List[int]) -> List[int]:
        sums.sort()
        res = []
        while len(sums) > 1:
            num = sums[-1] - sums[-2]
            res.append(num)
            new_sums = []
            count = collections.defaultdict(int)
            for x in sums:
                if count[x] > 0:
                    count[x] -= 1
                else:
                    new_sums.append(x)
                    count[x + num] += 1
            sums = new_sums
        return res[::-1]