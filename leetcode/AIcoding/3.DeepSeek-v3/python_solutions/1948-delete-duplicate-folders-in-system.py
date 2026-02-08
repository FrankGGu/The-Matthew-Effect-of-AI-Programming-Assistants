class TrieNode:
    def __init__(self):
        self.children = {}
        self.key = ""
        self.is_deleted = False

class Solution:
    def deleteDuplicateFolder(self, paths: List[List[str]]) -> List[List[str]]:
        root = TrieNode()
        for path in paths:
            node = root
            for folder in path:
                if folder not in node.children:
                    node.children[folder] = TrieNode()
                    node.children[folder].key = folder
                node = node.children[folder]

        key_to_nodes = defaultdict(list)

        def post_order(node):
            if not node.children:
                return ""
            children_keys = []
            for child in node.children.values():
                child_key = post_order(child)
                children_keys.append(child_key + ":" + child.key)
            key = "(" + ",".join(sorted(children_keys)) + ")"
            if key != "()":
                key_to_nodes[key].append(node)
            return key

        post_order(root)

        for nodes in key_to_nodes.values():
            if len(nodes) >= 2:
                for node in nodes:
                    node.is_deleted = True

        result = []

        def dfs(node, path):
            if node.is_deleted:
                return
            if path:
                result.append(path.copy())
            for child in node.children.values():
                path.append(child.key)
                dfs(child, path)
                path.pop()

        dfs(root, [])
        return result