class TopVotedCandidate:

    def __init__(self, persons: list[int], times: list[int]):
        self.persons = persons
        self.times = times
        self.leaders = []
        votes = {}
        leader = -1
        max_votes = 0
        for person in persons:
            votes[person] = votes.get(person, 0) + 1
            if votes[person] >= max_votes:
                max_votes = votes[person]
                leader = person
            self.leaders.append(leader)

    def q(self, t: int) -> int:
        l, r = 0, len(self.times) - 1
        while l <= r:
            mid = (l + r) // 2
            if self.times[mid] <= t:
                l = mid + 1
            else:
                r = mid - 1
        return self.leaders[r]