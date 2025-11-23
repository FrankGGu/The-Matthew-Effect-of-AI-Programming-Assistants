import collections

class LockingTree:

    def __init__(self, parent: list[int], nums: list[int]):
        self.n = len(parent)
        self.parent = parent
        self.locked_by = [-1] * self.n

        self.children = [[] for _ in range(self.n)]
        for i in range(1, self.n):
            p = parent[i]
            self.children[p].append(i)

    def lock(self, num: int, user: int) -> bool:
        if self.locked_by[num] == -1:
            self.locked_by[num] = user
            return True
        return False

    def unlock(self, num: int, user: int) -> bool:
        if self.locked_by[num] == user:
            self.locked_by[num] = -1
            return True
        return False

    def upgrade(self, num: int, user: int) -> bool:
        if self.locked_by[num] != -1:
            return False

        curr = num
        while curr != -1:
            if self.locked_by[curr] != -1:
                return False
            curr = self.parent[curr]

        locked_descendants = []
        q = collections.deque([num])
        found_locked_descendant = False

        while q:
            curr_node = q.popleft()

            if curr_node != num and self.locked_by[curr_node] != -1:
                found_locked_descendant = True
                locked_descendants.append(curr_node)

            for child in self.children[curr_node]:
                q.append(child)

        if not found_locked_descendant:
            return False

        self.locked_by[num] = user

        for node_to_unlock in locked_descendants:
            self.locked_by[node_to_unlock] = -1

        return True