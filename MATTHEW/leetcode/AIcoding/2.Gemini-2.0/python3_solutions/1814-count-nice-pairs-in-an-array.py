class Solution:
    def countNicePairs(self, nums: List[int]) -> int:
        def rev(n):
            res = 0
            while n > 0:
                res = res * 10 + n % 10
                n //= 10
            return res

        diffs = {}
        count = 0
        for num in nums:
            diff = num - rev(num)
            if diff in diffs:
                count = (count + diffs[diff]) % (10**9 + 7)
                diffs[diff] += 1
            else:
                diffs[diff] = 1
        return count