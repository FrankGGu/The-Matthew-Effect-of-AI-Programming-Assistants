def countStudents(students: List[int], sandwiches: List[int]) -> int:
    from collections import deque

    students = deque(students)
    sandwiches = deque(sandwiches)

    while sandwiches and students:
        if students[0] == sandwiches[0]:
            students.popleft()
            sandwiches.popleft()
        else:
            students.append(students.popleft())
        if all(s != sandwiches[0] for s in students):
            break

    return len(students)