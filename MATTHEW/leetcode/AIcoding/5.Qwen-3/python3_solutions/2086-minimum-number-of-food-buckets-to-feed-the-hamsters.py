class Solution:
    def minFoodBuckets(self, street: str) -> int:
        n = len(street)
        i = 0
        res = 0
        while i < n:
            if street[i] == 'H':
                if i + 1 < n and street[i + 1] == 'H':
                    res += 1
                    i += 2
                else:
                    res += 1
                    i += 1
            else:
                i += 1
        return res