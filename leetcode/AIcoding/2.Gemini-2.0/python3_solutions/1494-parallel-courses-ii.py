class Solution:
    def minNumberOfSemesters(self, n: int, dependencies: List[List[int]], k: int) -> int:
        indegree = [0] * n
        prerequisites = [0] * n
        for u, v in dependencies:
            u -= 1
            v -= 1
            prerequisites[v] |= (1 << u)
            indegree[v] += 1

        q = deque()
        for i in range(n):
            if indegree[i] == 0:
                q.append(i)

        semesters = 0
        taken = 0
        while taken < n:
            semesters += 1
            eligible_courses = []
            for i in range(n):
                if (taken & (1 << i)) == 0 and (prerequisites[i] & taken) == prerequisites[i]:
                    eligible_courses.append(i)

            eligible_courses.sort(key=lambda x: bin(prerequisites[x]).count('1'), reverse=True)

            take_count = 0
            for course in eligible_courses:
                if take_count < k:
                    taken |= (1 << course)
                    take_count += 1

        return semesters