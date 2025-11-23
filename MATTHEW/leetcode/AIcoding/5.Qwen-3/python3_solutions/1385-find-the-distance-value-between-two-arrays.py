class Solution:
    def findTheDistanceValue(self, arr1: List[int], arr2: int) -> int:
        arr2.sort()
        distance = 0
        for num in arr1:
            left, right = 0, len(arr2) - 1
            while left <= right:
                mid = (left + right) // 2
                if arr2[mid] < num:
                    left = mid + 1
                else:
                    right = mid - 1
            if left == 0:
                distance += abs(num - arr2[0])
            elif left == len(arr2):
                distance += abs(num - arr2[-1])
            else:
                distance += min(abs(num - arr2[left]), abs(num - arr2[left - 1]))
        return distance