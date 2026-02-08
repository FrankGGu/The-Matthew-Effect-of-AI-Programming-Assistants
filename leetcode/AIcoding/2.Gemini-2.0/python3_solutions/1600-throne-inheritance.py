class ThroneInheritance:

    def __init__(self, kingName: str):
        self.king = kingName
        self.graph = {}
        self.dead = set()

    def birth(self, parentName: str, childName: str) -> None:
        if parentName not in self.graph:
            self.graph[parentName] = []
        self.graph[parentName].append(childName)

    def death(self, name: str) -> None:
        self.dead.add(name)

    def getInheritanceOrder(self) -> List[str]:
        order = []
        def dfs(name):
            if name not in self.dead:
                order.append(name)
            if name in self.graph:
                for child in self.graph[name]:
                    dfs(child)
        dfs(self.king)
        return order