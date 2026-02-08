class Solution:
    def busyStudent(self, startTime: list[int], endTime: list[int], queryTime: int) -> int:
        count = 0
        for i in range(len(startTime)):
            if startTime[i] <= queryTime <= endTime[i]:
                count += 1
        return count