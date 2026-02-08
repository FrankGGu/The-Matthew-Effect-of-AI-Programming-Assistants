class Solution:
    def trainingPlan(self, trainers: list[int], students: list[int], k: int) -> int:
        trainers.sort()
        students.sort()

        n = len(trainers)
        m = len(students)

        count = 0
        i = 0
        j = 0

        while i < n and j < m and count < k:
            if trainers[i] <= students[j]:
                i += 1
            else:
                count += 1
                i += 1
                j += 1

        if count == k:
            return trainers[i-1]
        else:
            return -1