class Solution:
    def takeAttendance(self, records: List[int]) -> int:
        left, right = 0, len(records) - 1
        while left <= right:
            mid = left + (right - left) // 2
            if records[mid] == mid:
                left = mid + 1
            else:
                right = mid - 1
        return left