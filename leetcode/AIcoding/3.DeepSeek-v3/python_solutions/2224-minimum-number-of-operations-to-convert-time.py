class Solution:
    def convertTime(self, current: str, correct: str) -> int:
        def to_minutes(time_str):
            hh, mm = map(int, time_str.split(':'))
            return hh * 60 + mm

        current_min = to_minutes(current)
        correct_min = to_minutes(correct)
        diff = correct_min - current_min
        if diff < 0:
            diff += 24 * 60

        operations = 0
        for step in [60, 15, 5, 1]:
            operations += diff // step
            diff %= step

        return operations