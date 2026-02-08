class Solution:
    def numberOfRounds(self, startTime: str, finishTime: str) -> int:
        start_h, start_m = map(int, startTime.split(':'))
        finish_h, finish_m = map(int, finishTime.split(':'))

        start_minutes = start_h * 60 + start_m
        finish_minutes = finish_h * 60 + finish_m

        if finish_minutes < start_minutes:
            finish_minutes += 24 * 60

        rounds = 0
        start_minutes = (start_minutes + (15 - start_minutes % 15)) % (24 * 60)

        if start_minutes > finish_minutes:
            return 0

        rounds = (finish_minutes - start_minutes) // 15

        return rounds