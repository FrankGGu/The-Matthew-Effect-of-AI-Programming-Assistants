class Solution:
    def countStudents(self, students: List[int], sandwiches: List[int]) -> int:
        from collections import deque

        students_queue = deque(students)
        sandwiches_stack = deque(sandwiches)

        count = 0

        while students_queue and count < len(students_queue):
            if students_queue[0] == sandwiches_stack[0]:
                students_queue.popleft()
                sandwiches_stack.popleft()
                count = 0
            else:
                students_queue.append(students_queue.popleft())
                count += 1

        return len(students_queue)