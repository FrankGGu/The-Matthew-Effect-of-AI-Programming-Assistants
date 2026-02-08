class Solution:
    def haveConflict(self, event1: List[str], event2: List[str]) -> bool:
        def to_minutes(time_str):
            hh, mm = map(int, time_str.split(':'))
            return hh * 60 + mm

        start1, end1 = to_minutes(event1[0]), to_minutes(event1[1])
        start2, end2 = to_minutes(event2[0]), to_minutes(event2[1])

        return not (end1 < start2 or end2 < start1)