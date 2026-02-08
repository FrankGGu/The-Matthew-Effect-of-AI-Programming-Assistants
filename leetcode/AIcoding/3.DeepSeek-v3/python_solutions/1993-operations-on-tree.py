class LockingTree:

    def __init__(self, parent: List[int]):
        self.parent = parent
        self.children = [[] for _ in range(len(parent))]
        for i in range(1, len(parent)):
            self.children[parent[i]].append(i)
        self.locked = [None] * len(parent)

    def lock(self, num: int, user: int) -> bool:
        if self.locked[num] is None:
            self.locked[num] = user
            return True
        return False

    def unlock(self, num: int, user: int) -> bool:
        if self.locked[num] == user:
            self.locked[num] = None
            return True
        return False

    def upgrade(self, num: int, user: int) -> bool:
        if self.locked[num] is not None:
            return False

        current = num
        while current != -1:
            if self.locked[current] is not None:
                return False
            current = self.parent[current]

        stack = [num]
        has_locked_descendant = False
        while stack:
            node = stack.pop()
            if self.locked[node] is not None:
                has_locked_descendant = True
                self.locked[node] = None
            for child in self.children[node]:
                stack.append(child)

        if has_locked_descendant:
            self.locked[num] = user
            return True
        return False