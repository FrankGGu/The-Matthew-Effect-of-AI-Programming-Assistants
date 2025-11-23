class Solution:
    def haveConflict(self, event1: List[str], event2: List[str]) -> bool:
        start1, end1 = event1
        start2, end2 = event2

        def to_minutes(time):
            hours, minutes = map(int, time.split(':'))
            return hours * 60 + minutes

        s1 = to_minutes(start1)
        e1 = to_minutes(end1)
        s2 = to_minutes(start2)
        e2 = to_minutes(end2)

        return not (e1 < s2 or e2 < s1)