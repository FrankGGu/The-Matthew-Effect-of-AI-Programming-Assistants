class Solution:
    def countTriplets(self, nums: List[int]) -> int:
        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] ^ nums[i]

        count = 0
        for i in range(n):
            for j in range(i + 1, n):
                for k in range(j + 1, n):
                    a = prefix[j] ^ prefix[i]
                    b = prefix[k + 1] ^ prefix[j]
                    if a == b:
                        count += 1
        return count