class Solution:
    def maximumSwap(self, num: int) -> int:
        num = list(str(num))
        last = {int(d): i for i, d in enumerate(num)}
        for i in range(len(num)):
            for d in range(9, int(num[i]), -1):
                if str(d) in last and last[str(d)] > i:
                    num[i], num[last[str(d)]] = num[last[str(d)]], num[i]
                    return int(''.join(num))
        return int(''.join(num))