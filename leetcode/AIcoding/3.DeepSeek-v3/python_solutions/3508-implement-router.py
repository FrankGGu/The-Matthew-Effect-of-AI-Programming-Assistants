class TrieNode:
    def __init__(self):
        self.children = {}
        self.handler = None

class Router:
    def __init__(self, root_handler):
        self.root = TrieNode()
        self.root.handler = root_handler

    def add_handler(self, path, handler):
        node = self.root
        parts = path.split('/')[1:]
        for part in parts:
            if part not in node.children:
                node.children[part] = TrieNode()
            node = node.children[part]
        node.handler = handler

    def lookup(self, path):
        node = self.root
        if path == '/':
            return node.handler
        parts = path.split('/')[1:]
        for part in parts:
            if part in node.children:
                node = node.children[part]
            else:
                return None
        return node.handler