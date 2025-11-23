class Solution:
    def findSubarraysWithEqualSum(self, arr: List[int]) -> int:
        n = len(arr)
        seen = set()
        count = 0
        for i in range(n - 1):
            current_sum = arr[i] + arr[i + 1]
            if current_sum in seen:
                count += 1
            else:
                seen.add(current_sum)
        return count