class Router:
    def __init__(self):
        self.routes = {}

    def addRoute(self, path: str, handler: str) -> None:
        self.routes[path] = handler

    def removeRoute(self, path: str) -> None:
        if path in self.routes:
            del self.routes[path]

    def getRoute(self, path: str) -> str:
        return self.routes.get(path, None)