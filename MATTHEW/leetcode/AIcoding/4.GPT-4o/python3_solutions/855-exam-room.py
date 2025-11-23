class ExamRoom:

    def __init__(self, N: int):
        self.N = N
        self.students = []

    def seat(self) -> int:
        if not self.students:
            self.students.append(0)
            return 0
        max_dist = self.students[0]
        seat = 0
        for i in range(1, len(self.students)):
            dist = (self.students[i] - self.students[i - 1]) // 2
            if dist > max_dist:
                max_dist = dist
                seat = self.students[i - 1] + dist
        if self.N - 1 - self.students[-1] > max_dist:
            seat = self.N - 1
        self.students.append(seat)
        self.students.sort()
        return seat

    def leave(self, p: int) -> None:
        self.students.remove(p)