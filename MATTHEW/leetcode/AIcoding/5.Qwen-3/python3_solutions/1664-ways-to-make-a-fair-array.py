class Solution:
    def waysToMakeFair(self, arr: List[int]) -> int:
        n = len(arr)
        total = sum(arr)
        left_even = 0
        left_odd = 0
        count = 0
        for i in range(n):
            right_even = (total - left_even - left_odd - arr[i]) if i % 2 == 0 else (total - left_even - left_odd - arr[i])
            right_odd = (total - left_even - left_odd - arr[i]) if i % 2 == 1 else (total - left_even - left_odd - arr[i])
            if i % 2 == 0:
                left_even += arr[i]
            else:
                left_odd += arr[i]
            if left_even == right_even and left_odd == right_odd:
                count += 1
        return count