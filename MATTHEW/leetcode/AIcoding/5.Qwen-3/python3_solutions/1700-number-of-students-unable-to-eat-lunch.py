class Solution:
    def countStudents(self, students: List[int], sandwiches: List[int]) -> int:
        from collections import deque

        queue = deque(students)
        sandwich_index = 0

        while queue:
            if queue[0] == sandwiches[sandwich_index]:
                queue.popleft()
                sandwich_index += 1
            else:
                break

        return len(queue)