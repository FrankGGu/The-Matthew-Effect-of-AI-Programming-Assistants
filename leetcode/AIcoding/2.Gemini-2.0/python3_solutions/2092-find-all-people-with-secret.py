class Solution:
    def findAllPeople(self, n: int, meetings: List[List[int]], firstPerson: int) -> List[int]:
        parent = list(range(n))
        rank = [0] * n

        def find(i):
            if parent[i] == i:
                return i
            parent[i] = find(parent[i])
            return parent[i]

        def union(i, j):
            root_i = find(i)
            root_j = find(j)
            if root_i != root_j:
                if rank[root_i] < rank[root_j]:
                    parent[root_i] = root_j
                elif rank[root_i] > rank[root_j]:
                    parent[root_j] = root_i
                else:
                    parent[root_j] = root_i
                    rank[root_i] += 1

        union(0, firstPerson)

        meetings.sort(key=lambda x: x[2])
        i = 0
        while i < len(meetings):
            time = meetings[i][2]
            group = []
            while i < len(meetings) and meetings[i][2] == time:
                person1, person2, _ = meetings[i]
                group.append(person1)
                group.append(person2)
                union(person1, person2)
                i += 1

            for person in group:
                if find(person) != find(0):
                    parent[person] = person

        result = []
        for i in range(n):
            if find(i) == find(0):
                result.append(i)
        return result