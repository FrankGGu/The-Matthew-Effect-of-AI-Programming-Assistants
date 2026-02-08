class TopVotedCandidate:

    def __init__(self, persons: List[int], times: List[int]):
        self.times = times
        self.leader = []
        count = {}
        max_votes = 0
        current_leader = -1

        for person in persons:
            count[person] = count.get(person, 0) + 1
            if count[person] >= max_votes:
                max_votes = count[person]
                current_leader = person
            self.leader.append(current_leader)

    def q(self, t: int) -> int:
        idx = bisect.bisect_right(self.times, t) - 1
        return self.leader[idx]