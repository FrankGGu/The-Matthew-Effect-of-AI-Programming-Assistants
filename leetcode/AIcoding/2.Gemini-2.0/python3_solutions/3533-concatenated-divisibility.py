class Solution:
    def concatenatedDivisibility(self, nums: List[int], k: int) -> bool:
        curr = 0
        for num in nums:
            len_num = len(str(num))
            curr = (curr * (10 ** len_num) + num) % k
        return curr == 0