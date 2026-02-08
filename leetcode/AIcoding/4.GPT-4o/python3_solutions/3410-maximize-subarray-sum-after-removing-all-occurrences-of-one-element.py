class Solution:
    def maximumSum(self, arr: List[int], no: int) -> int:
        total_sum = sum(arr)
        max_sum = curr_sum = 0

        for num in arr:
            if num != no:
                curr_sum += num
                max_sum = max(max_sum, curr_sum)
            else:
                curr_sum = 0

        curr_sum = 0
        for num in arr:
            if num == no:
                curr_sum += num
            else:
                curr_sum = max(curr_sum + num, num)

        return max(max_sum, curr_sum, total_sum - arr.count(no) * no)