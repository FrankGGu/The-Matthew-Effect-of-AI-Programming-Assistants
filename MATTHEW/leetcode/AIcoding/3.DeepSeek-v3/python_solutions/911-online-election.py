class TopVotedCandidate:

    def __init__(self, persons: List[int], times: List[int]):
        self.times = times
        self.leaders = []
        vote_count = {}
        current_leader = -1
        max_votes = 0

        for i in range(len(persons)):
            person = persons[i]
            vote_count[person] = vote_count.get(person, 0) + 1
            if vote_count[person] >= max_votes:
                max_votes = vote_count[person]
                current_leader = person
            self.leaders.append(current_leader)

    def q(self, t: int) -> int:
        left, right = 0, len(self.times) - 1
        while left <= right:
            mid = (left + right) // 2
            if self.times[mid] <= t:
                left = mid + 1
            else:
                right = mid - 1
        return self.leaders[right]