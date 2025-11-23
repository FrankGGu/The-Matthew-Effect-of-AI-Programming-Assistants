def minMovesToSeat(seats, students):
    seats.sort()
    students.sort()
    return sum(abs(s - st) for s, st in zip(seats, students))