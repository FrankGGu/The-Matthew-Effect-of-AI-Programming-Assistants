class Solution:
    def findEvenNumbers(self, digits: List[int]) -> List[int]:
        from collections import defaultdict

        freq = defaultdict(int)
        for d in digits:
            freq[d] += 1

        res = []
        for num in range(100, 1000, 2):
            temp_freq = defaultdict(int)
            valid = True
            n = num
            while n > 0:
                d = n % 10
                temp_freq[d] += 1
                if temp_freq[d] > freq[d]:
                    valid = False
                    break
                n = n // 10
            if valid:
                res.append(num)

        return res