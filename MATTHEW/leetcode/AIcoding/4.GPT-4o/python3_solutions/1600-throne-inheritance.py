class TreeNode:
    def __init__(self, name):
        self.name = name
        self.children = []

class ThroneInheritance:
    def __init__(self, kingName: str):
        self.root = TreeNode(kingName)
        self.dead = set()

    def birth(self, parentName: str, childName: str) -> None:
        parent = self._find(self.root, parentName)
        if parent:
            parent.children.append(TreeNode(childName))

    def death(self, name: str) -> None:
        self.dead.add(name)

    def getInheritanceOrder(self) -> List[str]:
        order = []
        self._dfs(self.root, order)
        return order

    def _dfs(self, node, order):
        if node.name not in self.dead:
            order.append(node.name)
        for child in node.children:
            self._dfs(child, order)

    def _find(self, node, name):
        if node.name == name:
            return node
        for child in node.children:
            found = self._find(child, name)
            if found:
                return found
        return None