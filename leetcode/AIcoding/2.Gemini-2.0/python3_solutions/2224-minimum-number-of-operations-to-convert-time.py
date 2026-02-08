class Solution:
    def convertTime(self, current: str, correct: str) -> int:
        current_minutes = int(current[:2]) * 60 + int(current[3:])
        correct_minutes = int(correct[:2]) * 60 + int(correct[3:])
        diff = correct_minutes - current_minutes

        operations = 0
        operations += diff // 60
        diff %= 60
        operations += diff // 15
        diff %= 15
        operations += diff // 5
        diff %= 5
        operations += diff

        return operations