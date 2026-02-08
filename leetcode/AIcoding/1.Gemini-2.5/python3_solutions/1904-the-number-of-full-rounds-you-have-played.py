class Solution:
    def numberOfRounds(self, startTime: str, endTime: str) -> int:
        start_h = int(startTime[:2])
        start_m = int(startTime[3:])
        end_h = int(endTime[:2])
        end_m = int(endTime[3:])

        start_total_minutes = start_h * 60 + start_m
        end_total_minutes = end_h * 60 + end_m

        if end_total_minutes < start_total_minutes:
            end_total_minutes += 24 * 60

        first_round_start = (start_total_minutes + 14) // 15 * 15
        last_round_start = (end_total_minutes - 15) // 15 * 15

        if first_round_start > last_round_start:
            return 0

        return (last_round_start - first_round_start) // 15 + 1