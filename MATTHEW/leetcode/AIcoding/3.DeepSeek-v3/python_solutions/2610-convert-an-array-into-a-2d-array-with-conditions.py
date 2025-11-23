class Solution:
    def findMatrix(self, nums: List[int]) -> List[List[int]]:
        freq = {}
        for num in nums:
            freq[num] = freq.get(num, 0) + 1

        result = []
        while freq:
            row = []
            keys = list(freq.keys())
            for num in keys:
                row.append(num)
                freq[num] -= 1
                if freq[num] == 0:
                    del freq[num]
            result.append(row)
        return result