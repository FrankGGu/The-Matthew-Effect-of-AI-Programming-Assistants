class Solution:
    def countTime(self, time: str) -> int:
        hours, minutes = time.split(':')
        hour_count = 0
        minute_count = 0

        if hours == '**':
            hour_count = 24
        elif hours[0] == '*':
            hour_count = 3 if hours[1] < '4' else 2
        elif hours[1] == '*':
            hour_count = 10 if hours[0] == '2' else 10
        else:
            hour_count = 1

        if minutes == '**':
            minute_count = 60
        elif minutes[0] == '*':
            minute_count = 6
        elif minutes[1] == '*':
            minute_count = 10
        else:
            minute_count = 1

        return hour_count * minute_count