class MyCalendar:

    def __init__(self):
        self.calendar = []

    def book(self, start: int, end: int) -> bool:
        for booked_start, booked_end in self.calendar:
            # Check for overlap:
            # An overlap exists if the new interval (start, end)
            # starts before the booked interval ends AND
            # the booked interval starts before the new interval ends.
            if start < booked_end and booked_start < end:
                return False

        self.calendar.append([start, end])
        return True