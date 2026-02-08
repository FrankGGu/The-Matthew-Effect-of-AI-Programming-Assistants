class BrowserHistory:

    def __init__(self, homepage: str):
        self.history = [homepage]
        self.current = 0
        self.bound = 0

    def visit(self, url: str) -> None:
        self.current += 1
        if self.current < len(self.history):
            self.history[self.current] = url
        else:
            self.history.append(url)
        self.bound = self.current

    def back(self, steps: int) -> str:
        self.current = max(0, self.current - steps)
        return self.history[self.current]

    def forward(self, steps: int) -> str:
        self.current = min(self.bound, self.current + steps)
        return self.history[self.current]