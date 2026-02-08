class Solution:
    def convertTime(self, current: str, correct: str) -> int:
        current_hour = int(current[0:2])
        current_minute = int(current[3:5])
        correct_hour = int(correct[0:2])
        correct_minute = int(correct[3:5])

        current_total_minutes = current_hour * 60 + current_minute
        correct_total_minutes = correct_hour * 60 + correct_minute

        diff = correct_total_minutes - current_total_minutes
        operations = 0

        operations += diff // 60
        diff %= 60

        operations += diff // 15
        diff %= 15

        operations += diff // 5
        diff %= 5

        operations += diff // 1

        return operations