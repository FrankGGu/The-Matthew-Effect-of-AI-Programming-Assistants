class Solution:
    def numberOfFullRounds(self, startTime: str, endTime: str) -> int:
        def to_minutes(time):
            h, m = map(int, time.split(':'))
            return h * 60 + m

        start = to_minutes(startTime)
        end = to_minutes(endTime)

        if start > end:
            end += 24 * 60

        full_rounds = (end - start) // 60
        return full_rounds