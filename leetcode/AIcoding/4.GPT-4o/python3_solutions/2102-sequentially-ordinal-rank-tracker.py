class ORankTracker:

    def __init__(self):
        self.ranks = []

    def track(self, score: int) -> None:
        self.ranks.append(score)
        self.ranks.sort()

    def getRank(self, score: int) -> int:
        return len([x for x in self.ranks if x < score]) + 1