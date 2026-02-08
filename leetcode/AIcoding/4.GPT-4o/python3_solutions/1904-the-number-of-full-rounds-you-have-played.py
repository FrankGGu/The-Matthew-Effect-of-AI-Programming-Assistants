class Solution:
    def numberOfRounds(self, startTime: str, finishTime: str) -> int:
        start_hour, start_minute = map(int, startTime.split(':'))
        finish_hour, finish_minute = map(int, finishTime.split(':'))

        start_total_minutes = start_hour * 60 + start_minute
        finish_total_minutes = finish_hour * 60 + finish_minute

        if finish_total_minutes < start_total_minutes:
            finish_total_minutes += 24 * 60

        start_round = (start_total_minutes + 15) // 15
        finish_round = finish_total_minutes // 15

        return max(0, finish_round - start_round)