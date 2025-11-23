class Solution:
    def countBalls(self, lowLimit: int, highLimit: int) -> int:
        count = {}
        for i in range(lowLimit, highLimit + 1):
            key = sum(int(d) for d in str(i))
            if key in count:
                count[key] += 1
            else:
                count[key] = 1
        return len(count)