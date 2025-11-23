class Solution:
    def kIncreasing(self, arr: List[int], k: int) -> int:
        def length_of_lis(nums):
            tails = []
            for num in nums:
                idx = bisect.bisect_right(tails, num)
                if idx == len(tails):
                    tails.append(num)
                else:
                    tails[idx] = num
            return len(tails)

        total_operations = 0
        for i in range(k):
            subarray = arr[i::k]
            lis_length = length_of_lis(subarray)
            total_operations += len(subarray) - lis_length
        return total_operations