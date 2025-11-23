from collections import defaultdict

class ThroneInheritance:

    def __init__(self, kingName: str):
        self.king = kingName
        self.children = defaultdict(list)
        self.dead = set()

    def birth(self, parentName: str, childName: str) -> None:
        self.children[parentName].append(childName)

    def death(self, name: str) -> None:
        self.dead.add(name)

    def getInheritanceOrder(self) -> list[str]:
        order = []

        def dfs(person):
            if person not in self.dead:
                order.append(person)

            for child in self.children[person]:
                dfs(child)

        dfs(self.king)
        return order