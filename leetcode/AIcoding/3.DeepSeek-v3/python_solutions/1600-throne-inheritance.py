class ThroneInheritance:

    def __init__(self, kingName: str):
        self.king = kingName
        self.graph = defaultdict(list)
        self.dead = set()

    def birth(self, parentName: str, childName: str) -> None:
        self.graph[parentName].append(childName)

    def death(self, name: str) -> None:
        self.dead.add(name)

    def getInheritanceOrder(self) -> List[str]:
        order = []
        self._dfs(self.king, order)
        return order

    def _dfs(self, node, order):
        if node not in self.dead:
            order.append(node)
        for child in self.graph[node]:
            self._dfs(child, order)