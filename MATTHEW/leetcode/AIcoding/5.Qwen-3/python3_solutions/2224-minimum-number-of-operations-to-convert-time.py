class Solution:
    def convertTime(self, current: str, correct: str) -> int:
        def to_minutes(time_str):
            h, m = map(int, time_str.split(':'))
            return h * 60 + m

        current_min = to_minutes(current)
        correct_min = to_minutes(correct)

        diff = correct_min - current_min
        count = 0

        for t in [60, 15, 5, 1]:
            if diff >= t:
                count += diff // t
                diff %= t

        return count