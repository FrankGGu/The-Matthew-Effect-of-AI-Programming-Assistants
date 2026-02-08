class Solution:
    def haveConflict(self, event1: list[str], event2: list[str]) -> bool:
        def time_to_minutes(time_str: str) -> int:
            hours = int(time_str[:2])
            minutes = int(time_str[3:])
            return hours * 60 + minutes

        start1_minutes = time_to_minutes(event1[0])
        end1_minutes = time_to_minutes(event1[1])
        start2_minutes = time_to_minutes(event2[0])
        end2_minutes = time_to_minutes(event2[1])

        return start1_minutes <= end2_minutes and start2_minutes <= end1_minutes