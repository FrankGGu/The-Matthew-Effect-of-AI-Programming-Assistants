class Solution:
    def convertTime(self, current: str, correct: str) -> int:
        current_minutes = int(current[:2]) * 60 + int(current[3:])
        correct_minutes = int(correct[:2]) * 60 + int(correct[3:])
        diff = correct_minutes - current_minutes

        operations = 0
        for t in [60, 15, 5, 1]:
            operations += diff // t
            diff %= t

        return operations