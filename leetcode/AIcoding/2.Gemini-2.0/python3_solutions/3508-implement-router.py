class Node:
    def __init__(self):
        self.children = {}
        self.handler = None

class Router:
    def __init__(self):
        self.root = Node()

    def add_route(self, path, handler):
        path_parts = path.split('/')
        node = self.root
        for part in path_parts:
            if not part:
                continue
            if part not in node.children:
                node.children[part] = Node()
            node = node.children[part]
        node.handler = handler

    def route(self, path):
        path_parts = path.split('/')
        node = self.root
        for part in path_parts:
            if not part:
                continue
            if part not in node.children:
                return None
            node = node.children[part]
        return node.handler