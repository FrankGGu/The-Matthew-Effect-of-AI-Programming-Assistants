class LockingTree:

    def __init__(self, parent: list[int]):
        self.parent = parent
        self.locked = [0] * len(parent)
        self.children = [[] for _ in range(len(parent))]
        for i in range(1, len(parent)):
            self.children[parent[i]].append(i)

    def lock(self, num: int, user: int) -> bool:
        if self.locked[num] == 0:
            self.locked[num] = user
            return True
        else:
            return False

    def unlock(self, num: int, user: int) -> bool:
        if self.locked[num] == user:
            self.locked[num] = 0
            return True
        else:
            return False

    def upgrade(self, num: int, user: int) -> bool:
        if self.locked[num] != 0:
            return False

        p = self.parent[num]
        while p != -1:
            if self.locked[p] != 0:
                return False
            p = self.parent[p]

        has_locked_descendant = False
        def dfs(node):
            nonlocal has_locked_descendant
            if self.locked[node] != 0:
                has_locked_descendant = True
                return True

            for child in self.children[node]:
                if dfs(child):
                    return True
            return False

        if not dfs(num):
            return False

        def unlock_descendants(node):
            if self.locked[node] != 0:
                self.locked[node] = 0
            for child in self.children[node]:
                unlock_descendants(child)

        unlock_descendants(num)
        self.locked[num] = user
        return True